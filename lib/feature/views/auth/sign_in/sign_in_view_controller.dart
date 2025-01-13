import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:misyonbank/feature/views/navbar/navbar_view_controller.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/services/jwt_token_service.dart';
import 'package:misyonbank/product/services/sign_in_service.dart';

import '../../../../product/models/sign_in_request_model.dart';

class SignInViewController extends BaseGetxController {
  final navigatorKey = Get.nestedKey(1);
  final SignInService _signInService = Get.find<SignInService>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  var isEmailFocused = false.obs;
  var isPasswordVisible = false.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var isLoading = false.obs; // Add this line

  static const platform =
      MethodChannel('com.misyonbank.misyonbank/device_info');

  SignInViewController() {
    focusNodeEmail.addListener(() {
      isEmailFocused.value = focusNodeEmail.hasFocus;
    });
  }
  void navigateToLandingView() {
    Get.toNamed(AppRoutes.landingView, id: 1);
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  Future<String> _getLocation() async {
    try {
      bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return 'Location services are disabled.';
      }

      geo.LocationPermission permission =
          await geo.Geolocator.checkPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
        if (permission == geo.LocationPermission.denied) {
          return 'Location permissions are denied';
        }
      }

      if (permission == geo.LocationPermission.deniedForever) {
        return 'Location permissions are permanently denied, we cannot request permissions.';
      }

      geo.Position position = await geo.Geolocator.getCurrentPosition();
      return '${position.latitude}, ${position.longitude}';
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
      return 'Error getting location';
    }
  }

  Future<String> _getDeviceInfo() async {
    try {
      final String result = await platform.invokeMethod('getDeviceInfo');
      return result;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to get device info: '${e.message}'.");
      }
      return "Failed to get device info";
    }
  }

  void signIn() async {
    isLoading.value = true; // Set loading state to true
    emailError.value = '';
    passwordError.value = '';

    if (emailController.text.isEmpty) {
      emailError.value = 'Lütfen mail adresinizi giriniz.';
    } else if (!isValidEmail(emailController.text)) {
      emailError.value = 'Geçerli bir mail adresi giriniz.';
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Lütfen şifrenizi giriniz.';
    }

    if (emailError.value.isEmpty && passwordError.value.isEmpty) {
      final location = await _getLocation();
      final deviceInfo = await _getDeviceInfo();

      final signInRequestModel = SignInRequestModel(
        emailAddress: emailController.text,
        password: passwordController.text,
        location: location,
        deviceInfo: deviceInfo,
      );

      if (kDebugMode) {
        print('SignInRequestModel: ${signInRequestModel.toJson()}');
      }

      try {
        final response = await _signInService.signIn(signInRequestModel);

        if (response != null && response.statusCode == 200) {
          final jwtToken = response.data['data']['jwt'];
          if (jwtToken != null) {
            final jwtTokenService = Get.find<JwtTokenService>();
            jwtTokenService.setJwtToken(jwtToken);
            Get.find<NavbarViewController>().changeView(2);
            Get.close(1);
            Get.snackbar(
              "Başarıyla giriş yaptınız",
              response.data['fullname'] ?? emailController.text,
              backgroundColor: AppColors.white,
              colorText: AppColors.primaryColor,
            );
          } else {
            if (kDebugMode) {
              print('JWT token not found in response');
            }
            Get.snackbar(
              "Giriş Başarısız",
              "JWT token bulunamadı.",
              backgroundColor: AppColors.white,
              colorText: AppColors.primaryRedColor,
            );
          }
        } else {
          if (kDebugMode) {
            print('Sign-in failed');
          }
          Get.snackbar(
            "Giriş Başarısız",
            "Giriş işlemi başarısız oldu.",
            backgroundColor: AppColors.white,
            colorText: AppColors.primaryRedColor,
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error during sign-in: $e');
        }
        Get.snackbar(
          "Giriş Başarısız",
          "Bir hata oluştu: $e",
          backgroundColor: AppColors.white,
          colorText: AppColors.primaryRedColor,
        );
      }
    }
    isLoading.value = false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.onClose();
  }
}

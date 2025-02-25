import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:misyonbank/product/config/network.dart';
import 'package:misyonbank/product/models/sign_in_request_model.dart';
import 'package:dio/dio.dart' as dio;

class SignInService extends BaseGetxService {
  final Rx<SignInRequestModel?> _signInRequest = Rx<SignInRequestModel?>(null);
  SignInRequestModel? get signInRequest => _signInRequest.value;

  final Dio _dio = Get.find();

  Future<dio.Response?> signIn(SignInRequestModel requestModel) async {
    const String url = '$baseURL/auth/signin';

    try {
      final dio.Response response = await _dio.post(
        url,
        data: requestModel.toJson(),
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Giriş başarılı
        if (kDebugMode) {
          print('Sign-in successful: ${response.data}');
        }
        _signInRequest.value = requestModel;
      } else {
        // Hata durumu
        if (kDebugMode) {
          print('Sign-in failed with status: ${response.statusCode}');
        }
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Sign-in request failed: $e');
      }
      return null;
    }
  }
}

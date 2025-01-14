import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/views/auth/sign_in/sign_in_view_controller.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:widgets/components.dart';

class SignInView extends BaseGetView<SignInViewController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildSignInForm(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Image.asset(
          AssetConstants.fonvestorLogo,
          fit: BoxFit.contain,
        ),
      ),
      leadingWidth: 120.w,
      backgroundColor: AppColors.backgroundColor,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Icon(
            Icons.menu,
            color: AppColors.subTitleGreyColor,
            size: 26.sp,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey,
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ScaleFactorAutoSizeText(
                text: "Giriş Yap",
                style: theme.primaryTextTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Focus(
              focusNode: controller.focusNodeEmail,
              child: Obx(() {
                return TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: "e-Posta",
                    labelStyle: TextStyle(
                      color: controller.emailError.value.isEmpty
                          ? AppColors.hintColor
                          : AppColors.primaryRedColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                    errorText: controller.emailError.value.isEmpty
                        ? null
                        : controller.emailError.value,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: controller.emailError.value.isEmpty
                            ? AppColors.hintColor
                            : AppColors.primaryRedColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: controller.emailError.value.isEmpty
                            ? theme.hintColor
                            : AppColors.primaryRedColor,
                        width: 2,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) =>
                      controller.focusNodePassword.requestFocus(),
                );
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Obx(() {
              return TextField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  hintText: "Şifre",
                  labelText: "Şifre",
                  labelStyle: TextStyle(
                    color: controller.passwordError.value.isEmpty
                        ? AppColors.hintColor
                        : AppColors.primaryRedColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                  errorText: controller.passwordError.value.isEmpty
                      ? null
                      : controller.passwordError.value,
                  hintStyle: TextStyle(
                    color: AppColors.hintColor,
                    fontSize: 15.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: controller.passwordError.value.isEmpty
                          ? AppColors.hintColor
                          : AppColors.primaryRedColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: controller.passwordError.value.isEmpty
                          ? theme.hintColor
                          : AppColors.primaryRedColor,
                      width: 2,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                focusNode: controller.focusNodePassword,
                obscureText: !controller.isPasswordVisible.value,
              );
            }),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => Get.launchURL(
                    'https://crowd.nexasoft.io/sifre/sifremi-unuttum'),
                child: ScaleFactorAutoSizeText(
                  text: "Şifremi Unuttum?",
                  style: theme.primaryTextTheme.bodyMedium!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          Obx(() {
            return CustomButton(
              backgroundColor: AppColors.primaryColor,
              disabledBackgroundColor: AppColors.primaryColor,
              onTap: controller.isLoading.value ? null : controller.signIn,
              borderRadius: 100.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller.isLoading.value)
                    const SizedBox(
                      width: 24, // Set the desired width
                      height: 24, // Set the desired height
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.primaryColor,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.white),
                      ),
                    ),
                  if (controller.isLoading.value) SizedBox(width: 10.w),
                  ScaleFactorAutoSizeText(
                    text: "Giriş Yap",
                    style: theme.primaryTextTheme.headlineMedium!.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleFactorAutoSizeText(
                text: "Hesabınız yok mu?",
                style: theme.primaryTextTheme.bodyMedium!.copyWith(
                  color: AppColors.grey800Color,
                ),
              ),
              SizedBox(width: 5.w),
              InkWell(
                onTap: () =>
                    Get.launchURL('https://crowd.nexasoft.io/kayit-ol'),
                child: ScaleFactorAutoSizeText(
                  text: "Kayıt Ol",
                  style: theme.primaryTextTheme.bodyMedium!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

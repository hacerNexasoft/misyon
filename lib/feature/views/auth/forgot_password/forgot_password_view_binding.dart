
import 'package:common/common.dart';
import 'package:misyonbank/feature/views/auth/forgot_password/forgot_password_view_controller.dart';

class ForgotPasswordViewBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.put(ForgotPasswordViewController());
  }
}
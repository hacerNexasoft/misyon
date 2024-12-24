import 'package:common/common.dart';
import 'package:misyonbank/feature/views/auth/sign_in/sign_in_view_controller.dart';

class SignInViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInViewController());
  }
}

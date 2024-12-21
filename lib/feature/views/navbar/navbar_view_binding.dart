import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/navbar_view_controller.dart';

class NavbarViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavbarViewController());
  }
}

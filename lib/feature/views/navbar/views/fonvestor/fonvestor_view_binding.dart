import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/fonvestor_view_controller.dart';

class FonvestorViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FonvestorViewController());
  }
}

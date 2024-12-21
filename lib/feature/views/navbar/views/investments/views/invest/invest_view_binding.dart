import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/views/invest/invest_view_controller.dart';

class InvestViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InvestViewController(Get.arguments));
  }
}

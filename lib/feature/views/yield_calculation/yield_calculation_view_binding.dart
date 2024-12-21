import 'package:common/common.dart';
import 'package:misyonbank/feature/views/yield_calculation/yield_calculation_view_controller.dart';

class YieldCalculationViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(YieldCalculationViewController());
  }
}

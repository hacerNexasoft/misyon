import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/investments_view_controller.dart';

class InvestmentsViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InvestmentsViewController());
  }
}

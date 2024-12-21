import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/buy_sell/buy_sell_view_controller.dart';

class BuySellViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BuySellViewController());
  }
}

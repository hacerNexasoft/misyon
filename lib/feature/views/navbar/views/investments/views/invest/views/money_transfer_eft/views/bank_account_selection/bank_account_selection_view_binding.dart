import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/views/invest/views/money_transfer_eft/views/bank_account_selection/bank_account_selection_view_controller.dart';

class BankAccountSelectionViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BankAccountSelectionViewController());
  }
}

import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/transactions_view_controller.dart';

class TransactionsViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TransactionsViewController());
  }
}

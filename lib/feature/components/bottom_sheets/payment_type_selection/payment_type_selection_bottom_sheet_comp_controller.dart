import 'package:common/common.dart';
import 'package:misyonbank/product/constants/app_constants.dart';
import 'package:misyonbank/product/models/payment_type_model.dart';

class PaymentTypeSelectionBottomSheetCompController extends BaseGetxController {
  final filteredPaymentTypes = <PaymentTypeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    change(state, status: RxStatus.success());
    filteredPaymentTypes.addAll(AppConstants.paymentTypes);
  }

  void filterPaymentTypes(String query) {
    if (query.isEmpty) {
      if (filteredPaymentTypes.length != AppConstants.paymentTypes.length) {
        filteredPaymentTypes
          ..clear()
          ..addAll(AppConstants.paymentTypes);
      }
      change(state, status: RxStatus.success());
      return;
    }

    final filteredList = AppConstants.paymentTypes
        .where((paymentType) => paymentType.title.tr.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredPaymentTypes.length != filteredList.length) {
      filteredPaymentTypes
        ..clear()
        ..addAll(filteredList);
    }

    change(state, status: filteredList.isEmpty ? RxStatus.empty() : RxStatus.success());
  }
}

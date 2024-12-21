import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/components/bottom_sheets/payment_type_selection/payment_type_selection_bottom_sheet_comp_controller.dart';
import 'package:misyonbank/feature/components/search/search_comp.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/payment_type_model.dart';
import 'package:widgets/components.dart';

part 'widgets/payment_type_selection_comp_header_widget.dart';
part 'widgets/payment_type_list_widget.dart';

class PaymentTypeSelectionBottomSheetComp extends BaseStatelessWidget {
  const PaymentTypeSelectionBottomSheetComp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentTypeSelectionBottomSheetCompController>(
        init: PaymentTypeSelectionBottomSheetCompController(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
            width: Get.width,
            height: Get.height * .9,
            child: Column(
              children: [
                _PaymentTypeSelectionCompHeaderWidget(),
                SizedBox(height: 10.h),
                SearchComp(
                    hintText: LocalizationKeys.searchTextKey,
                    onChanged: controller.filterPaymentTypes),
                SizedBox(height: 10.h),
                _PaymentTypeListWidget(),
              ],
            ),
          );
        });
  }
}

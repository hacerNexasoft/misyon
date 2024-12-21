part of '../payment_type_selection_bottom_sheet_comp.dart';

class _PaymentTypeListWidget
    extends BaseGetView<PaymentTypeSelectionBottomSheetCompController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (_) => Obx(
        () => ListView.builder(
          padding: EdgeInsets.zero.w,
          shrinkWrap: true,
          itemCount: controller.filteredPaymentTypes.length,
          itemBuilder: (context, index) {
            final paymentType = controller.filteredPaymentTypes[index];
            return _paymentTypeItem(paymentType);
          },
        ),
      ),
      onEmpty: Expanded(
          child: Container(
        padding: EdgeInsets.all(40.w),
        alignment: Alignment.center,
        child: EmptyWidget(
          image: AssetConstants.emptyItemIcon,
          text: LocalizationKeys.emptySearchTextKey.tr,
          size: 75.h,
        ),
      )),
    );
  }

  Widget _paymentTypeItem(PaymentTypeModel paymentType) {
    return ListTile(
      onTap: () {
        Get.back(result: paymentType);
      },
      title: ScaleFactorAutoSizeText(
        text: paymentType.title.tr,
        style: theme.primaryTextTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.darkGreyColor,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColors.checkboxBorderColor,
        size: 40.w,
      ),
    );
  }
}

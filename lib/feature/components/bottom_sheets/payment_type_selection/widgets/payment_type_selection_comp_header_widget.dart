part of '../payment_type_selection_bottom_sheet_comp.dart';

class _PaymentTypeSelectionCompHeaderWidget extends BaseStatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _closeIcon,
        _header,
      ],
    );
  }

  Widget get _closeIcon => Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          padding: EdgeInsets.all(5.w),
          decoration: const BoxDecoration(
            color: AppColors.fillColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.close,
            color: AppColors.primaryGreyColor,
          ),
        ),
      ));

  Widget get _header => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleFactorAutoSizeText(
              text: LocalizationKeys.paymentTypeTextKey.tr,
              style: theme.primaryTextTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            ScaleFactorAutoSizeText(
              text: LocalizationKeys.selectPaymentTypeTextKey.tr,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: AppColors.primaryGreyColor,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      );
}

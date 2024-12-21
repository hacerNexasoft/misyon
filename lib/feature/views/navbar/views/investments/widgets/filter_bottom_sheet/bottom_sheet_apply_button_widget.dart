part of '../../investments_view.dart';

class _ApplyButtonWidget extends BaseGetView<InvestmentsViewController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
      child: CustomButton(
        borderRadius: 999.r,
        onTap: () {
          Get.back();
        },
        child: ScaleFactorAutoSizeText(
          text: LocalizationKeys.applyTextKey.tr,
          style: theme.primaryTextTheme.bodyLarge!.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

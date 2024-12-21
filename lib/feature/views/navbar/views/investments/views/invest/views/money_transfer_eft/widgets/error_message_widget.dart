part of '../../../invest_view.dart';

class _ErrorMessageWidget extends BaseGetView<InvestViewController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
      decoration: BoxDecoration(
        color: AppColors.errorWarningWidgetColor,
        borderRadius: BorderRadius.circular(Get.width * .5),
      ),
      child: Row(
        children: [
          Expanded(
            child: ScaleFactorAutoSizeText(
              text: controller.getInvestAmountErrorText(),
              style: theme.primaryTextTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(Get.width * .5),
              ),
              child: ScaleFactorAutoSizeText(
                text: controller.getErrorWidgetInfoText(),
                style: theme.primaryTextTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

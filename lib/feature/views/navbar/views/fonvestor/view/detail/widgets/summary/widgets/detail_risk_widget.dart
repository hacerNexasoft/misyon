part of '../summary_view.dart';

class DetailRiskWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();
  DetailRiskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle,
        SizedBox(height: 5.h),
        _buildRisk,
        SizedBox(height: 20.h),
        _buildRiskSlider
      ],
    );
  }

  Widget get _buildTitle => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ScaleFactorAutoSizeText(
              text: LocalizationKeys.riskdetailTitleKey.tr,
              style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                color: AppColors.toolTipGreyColor,
              ),
            ),
          ),
          Container(
            width: Get.width,
            height: 1.h,
            color: AppColors.fillColor,
          )
        ],
      );
  Widget get _buildRisk => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
        child: ScaleFactorAutoSizeText(
          text: LocalizationKeys.riskdetailTextKey.tr,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.primaryTextTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkGreyColor,
          ),
        ),
      );

  Widget get _buildRiskSlider => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: RiskWidget(
          currentRisk:
              controller.selectedProjectFundingInfo!.riskValue?.toInt(),
        ),
      );
}

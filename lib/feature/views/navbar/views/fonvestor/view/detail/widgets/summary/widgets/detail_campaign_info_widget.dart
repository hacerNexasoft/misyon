part of '../summary_view.dart';

class DetailCampaignInfoWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  DetailCampaignInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [_buildTitle, _buildDataCard],
          ),
        ],
      ),
    );
  }

  Widget get _buildTitle => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ScaleFactorAutoSizeText(
              text: LocalizationKeys.campaigndetailsTextKey.tr,
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
  Widget get _buildDataCard => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            child: Row(
              children: [
                Expanded(
                  child: CampaignCardWidget(
                    title: LocalizationKeys.startTextKey.tr,
                    data: DateTime.fromMillisecondsSinceEpoch(
                            controller.selectedProjectInvestmentInfo!.projectStartDate)
                        .toString(),
                    icon: AssetConstants.start,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CampaignCardWidget(
                    title: LocalizationKeys.stopTextKey.tr,
                    data: DateTime.fromMillisecondsSinceEpoch(
                            controller.selectedProjectInvestmentInfo!.projectEndDate)
                        .toString(),
                    icon: AssetConstants.stop,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            child: Row(
              children: [
                Expanded(
                  child: CampaignCardWidget(
                    title: LocalizationKeys.finishTextKey.tr,
                    data: "controller.selectedProjectDetails.value?.finishDate ",
                    icon: AssetConstants.calendar,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CampaignCardWidget(
                    title: LocalizationKeys.lotTextKey.tr,
                    data: "controller.selectedProjectDetails.value?.lot ",
                    icon: AssetConstants.datavis2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            child: Row(
              children: [
                Expanded(
                  child: CampaignCardWidget(
                    title: LocalizationKeys.percentTextKey.tr,
                    data: "controller.selectedProjectDetails.value?.percent",
                    icon: AssetConstants.percentage,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CampaignCardWidget(
                    title: LocalizationKeys.additionalAmountTextKey.tr,
                    data: "controller.selectedProjectDetails.value?.sharePcs",
                    icon: AssetConstants.number1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            child: Row(
              children: [
                Expanded(
                  child: CampaignCardWidget(
                    title: LocalizationKeys.sharePcsTextKey.tr,
                    data: (controller.selectedProjectInvestmentInfo!.additionalFundingRate ?? "")
                        .toString(),
                    icon: AssetConstants.start,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CampaignCardWidget(
                    title: LocalizationKeys.additionalFundRateTextKey.tr,
                    data: (controller.selectedProjectInvestmentInfo!.extraFundingAmount ?? "")
                        .toString(),
                    icon: AssetConstants.addalt,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            child: Row(
              children: [
                Expanded(
                  child: CampaignCardWidget(
                    title: LocalizationKeys.collateralStructureTextKey.tr,
                    data: controller.selectedProjectFundingInfo!.collateralStructure != null
                        ? ModelHelpers.localizedCollateralStructure(
                            controller.selectedProjectFundingInfo!.collateralStructure!)
                        : null,
                    icon: AssetConstants.document,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CampaignCardWidget(
                    title: LocalizationKeys.companyValuesTextKey.tr,
                    data: "controller.selectedProjectDetails.value?.companyValues",
                    icon: AssetConstants.chartline,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

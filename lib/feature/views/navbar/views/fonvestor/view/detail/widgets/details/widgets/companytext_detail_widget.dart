part of '../details_tab_view.dart';

class CompanytextDetailWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  CompanytextDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildsubTitle,
          SizedBox(
            height: 20.h,
          ),
          _buildProblem,
          SizedBox(height: 30.h),
          _buildIncomePlan,
          SizedBox(height: 30.h),
          _buildSolution,
          SizedBox(height: 30.h),
          _buildShowMore,
        ],
      ),
    );
  }

  Widget get _buildsubTitle => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ScaleFactorAutoSizeText(
              text: LocalizationKeys.aboutcompanydetailTitleTextKey.tr,
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
  Widget get _buildProblem => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleFactorAutoSizeText(
              textAlign: TextAlign.start,
              text: LocalizationKeys.companyproblemTextKey.tr,
              style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 15.h),
            ScaleFactorAutoSizeText(
              textAlign: TextAlign.start,
              text: controller.projectDetailModel.value?.problem ?? '',
              style: theme.primaryTextTheme.bodySmall?.copyWith(
                color: AppColors.grey700Color,
              ),
            ),
          ],
        ),
      );

  Widget get _buildIncomePlan => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleFactorAutoSizeText(
              textAlign: TextAlign.start,
              text: LocalizationKeys.companyincomePlanTextKey.tr,
              style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 15.h),
            ScaleFactorAutoSizeText(
              textAlign: TextAlign.start,
              text: controller.projectDetailModel.value?.incomePlan ?? '',
              style: theme.primaryTextTheme.bodySmall?.copyWith(
                color: AppColors.grey700Color,
              ),
            ),
          ],
        ),
      );

  Widget get _buildSolution => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleFactorAutoSizeText(
              textAlign: TextAlign.start,
              text: LocalizationKeys.companysolutionTextKey.tr,
              style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 15.h),
            ScaleFactorAutoSizeText(
              textAlign: TextAlign.start,
              text: controller.projectDetailModel.value?.solution ?? '',
              style: theme.primaryTextTheme.bodySmall?.copyWith(
                color: AppColors.grey700Color,
              ),
            ),
          ],
        ),
      );

  Widget get _buildShowMore => Center(
        child: ScaleFactorAutoSizeText(
          text: LocalizationKeys.showmoreTextKey.tr,
          style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      );
}

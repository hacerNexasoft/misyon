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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
              controller.selectedProjectDetails!.description,
              textStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
                  //color: AppColors.primaryGreyColor,
                  ),
            ),
          ),
          /*SizedBox(height: 30.h),
          _buildShowMore,*/
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

  Widget get _buildShowMore => Center(
        child: ScaleFactorAutoSizeText(
          text: LocalizationKeys.showmoreTextKey.tr,
          style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      );
}

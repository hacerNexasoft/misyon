part of '../summary_view.dart';

class DetailTagsWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  DetailTagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle,
        SizedBox(height: 10.h),
        _buildTags,
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
              text: LocalizationKeys.tagsdetailTextKey.tr,
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

  Widget get _buildTags => Padding(
        padding: EdgeInsets.symmetric(vertical: 5.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: controller.projectDetailModel.value?.tags
                  ?.map((document) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: Get.height * 0.01),
                        decoration: BoxDecoration(
                          color: AppColors.fillColor,
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                        child: ScaleFactorAutoSizeText(
                          text: document,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.primaryTextTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGreyColor,
                          ),
                        ),
                      ))
                  .toList() ??
              [],
        ),
      );
}

part of '../summary_view.dart';

class DetailFeaturedWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  DetailFeaturedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle,
        SizedBox(height: 20.h),
        _buildStar,
        _buildEye,
        _buildIncreasing
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
              text: LocalizationKeys.featuredTitleTextKey.tr,
              style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
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
  Widget get _buildStar => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
        child: Row(
          children: [
            SvgPicture.asset(
              AssetConstants.starIcon,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: ScaleFactorAutoSizeText(
                text: LocalizationKeys.featuredStarTextKey.tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.primaryTextTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkTextColor,
                ),
              ),
            ),
          ],
        ),
      );
  Widget get _buildEye => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
        child: Row(
          children: [
            SvgPicture.asset(
              AssetConstants.eyeIcon,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: ScaleFactorAutoSizeText(
                text: LocalizationKeys.featuredEyeTextKey.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.primaryTextTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkTextColor,
                ),
              ),
            ),
          ],
        ),
      );
  Widget get _buildIncreasing => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
        child: Row(
          children: [
            SvgPicture.asset(
              AssetConstants.increasingIcon,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: ScaleFactorAutoSizeText(
                text: LocalizationKeys.featuredIncreasingTextKey.tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.primaryTextTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkTextColor,
                ),
              ),
            ),
          ],
        ),
      );
}

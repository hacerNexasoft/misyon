part of '../fonvestor_view.dart';

class _AllAlternativeOpportunitiesWidget extends BaseStatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.investmentOpportunities,
          arguments: LocalizationKeys.allTextslowerKey.tr),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        height: 40.h,
        width: 169.w,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ScaleFactorAutoSizeText(
                text: LocalizationKeys.allAlternativeOpportunitiesTextKey.tr,
                style: theme.primaryTextTheme.bodyMedium?.copyWith(
                  color: AppColors.lightTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SvgPicture.asset(
              AssetConstants.searchIcon,
              width: 24.w,
            ),
          ],
        ),
      ),
    );
  }
}

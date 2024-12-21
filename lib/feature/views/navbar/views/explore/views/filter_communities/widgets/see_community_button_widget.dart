part of '../filter_communities_view.dart';

class _SeeCommunityButton extends BaseStatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
      child: CustomButton(
        borderRadius: 999.r,
        onTap: () {},
        child: ScaleFactorAutoSizeText(
          text: LocalizationKeys.seeCommunityTextKey.tr,
          style: theme.primaryTextTheme.bodyLarge!.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

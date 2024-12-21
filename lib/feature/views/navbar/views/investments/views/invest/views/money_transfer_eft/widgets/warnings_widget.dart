part of '../../../invest_view.dart';

class _WarningsWidget extends BaseStatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _infoItem(title: LocalizationKeys.maxInvestAmountInfoTextKey.tr),
        SizedBox(height: 10.h),
        _infoItem(title: LocalizationKeys.minInvestAmountInfoTextKey.tr),
      ],
    );
  }

  Widget _infoItem({required String title}) => Row(
        children: [
          SvgPicture.asset(
            AssetConstants.infoIcon,
            width: 20.w,
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ScaleFactorAutoSizeText(
                text: title,
                style: theme.primaryTextTheme.bodySmall?.copyWith(
                  color: AppColors.darkGreyColor,
                ),
                maxLines: 2,
              ),
            ),
          ),
        ],
      );
}

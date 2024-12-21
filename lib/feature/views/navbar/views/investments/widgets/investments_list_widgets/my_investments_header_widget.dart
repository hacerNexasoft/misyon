part of '../../investments_view.dart';

class _MyInvestmentsHeaderWidget
    extends BaseGetView<InvestmentsViewController> {
  const _MyInvestmentsHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Column(
        children: [
          Divider(
            color: AppColors.secondaryGreyColor,
            height: 0.5.sp,
          ),
          _buildFilter(),
          Divider(
            color: AppColors.secondaryGreyColor,
            height: 0.5.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildFilter() {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => Get.bottomSheet(_FilterBottomSheet()),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                ScaleFactorAutoSizeText(
                  text: LocalizationKeys.allTextKey.tr,
                  style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.primaryColor,
                  size: 25.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

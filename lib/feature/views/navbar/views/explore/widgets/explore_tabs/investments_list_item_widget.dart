part of '../../explore_view.dart';

class _InvestmentsListItemWidget extends BaseStatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? ceo;
  final double? amount;
  final String? label;
  final Color? color;
  final Color? textColor;
  final String? minutes;
  final VoidCallback? onTap;

  const _InvestmentsListItemWidget(
      {required this.imageUrl,
      required this.name,
      required this.ceo,
      required this.amount,
      required this.label,
      required this.minutes,
      required this.textColor,
      this.onTap,
      required this.color});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(
              color: AppColors.athensGray,
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  ProjectCustomCachedNetworkImageComp(
                    imageUrl: imageUrl,
                    size: 40.w,
                  ),
                  SizedBox(width: 20.w),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScaleFactorAutoSizeText(
                          text: name ?? '',
                          style: theme.primaryTextTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            ScaleFactorAutoSizeText(
                              text: ceo ?? '',
                              style: theme.primaryTextTheme.bodySmall
                                  ?.copyWith(color: AppColors.primaryGreyColor),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            ScaleFactorAutoSizeText(
                              text: minutes ?? '',
                              style: theme.primaryTextTheme.bodySmall
                                  ?.copyWith(color: AppColors.primaryGreyColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ScaleFactorAutoSizeText(
                  text: Formatter.formatMoney(amount),
                  maxLines: 1,
                  style: theme.primaryTextTheme.bodyLarge,
                ),
                SizedBox(height: 5.h),
                Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                  child: ScaleFactorAutoSizeText(
                    text: label ?? '',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: theme.primaryTextTheme.bodySmall?.copyWith(
                        color: textColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

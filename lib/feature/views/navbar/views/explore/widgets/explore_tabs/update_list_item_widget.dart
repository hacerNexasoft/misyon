part of '../../explore_view.dart';

class UpdateListItemWidget extends BaseStatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? updatesTitle;
  final String? updatesSubTitle;
  final String? date;
  final VoidCallback? onTap;

  const UpdateListItemWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.updatesTitle,
    required this.updatesSubTitle,
    required this.date,
    this.onTap,
  });

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      ProjectCustomCachedNetworkImageComp(
                        imageUrl: imageUrl,
                        size: 30.w,
                      ),
                      SizedBox(width: 10.w),
                      ScaleFactorAutoSizeText(
                        text: name ?? '',
                        style: theme.primaryTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                ScaleFactorAutoSizeText(
                  text: date ?? '',
                  style: theme.primaryTextTheme.bodyMedium?.copyWith(
                    color: AppColors.darkGreyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ScaleFactorAutoSizeText(
              text: updatesTitle ?? '',
              textAlign: TextAlign.start,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            ScaleFactorAutoSizeText(
              text: updatesSubTitle ?? '',
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: AppColors.darkGreyColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

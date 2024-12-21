import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:widgets/components.dart';

class CustomUpdatesWidget extends BaseStatelessWidget {
  final String? history;
  final String? years;
  final String? title;
  final String? description;

  const CustomUpdatesWidget({
    super.key,
    this.history,
    this.years,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: ScaleFactorAutoSizeText(
                textAlign: TextAlign.start,
                text: history ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: ScaleFactorAutoSizeText(
                textAlign: TextAlign.start,
                text: years ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 10.w),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.fillColor,
                borderRadius: BorderRadius.circular(Get.width * 0.02)),
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 6.w),
                  child: ScaleFactorAutoSizeText(
                    text: title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
                if (description != null && description!.isNotEmpty)
                  ScaleFactorAutoSizeText(
                    text: description ?? '',
                    style: theme.primaryTextTheme.bodySmall?.copyWith(
                      color: AppColors.grey500Color,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

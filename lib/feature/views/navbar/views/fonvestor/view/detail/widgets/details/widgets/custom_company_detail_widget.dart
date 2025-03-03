import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:widgets/components.dart';

class CustomCompanyDetailWidget extends BaseStatelessWidget {
  final String? title;
  final String? explanation;
  const CustomCompanyDetailWidget({
    super.key,
    this.title,
    this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.w),

      width: Get.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ScaleFactorAutoSizeText(
              textAlign: TextAlign.start,
              text: title ?? '',
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Expanded(
            flex: 2,
            child: ScaleFactorAutoSizeText(
              textAlign: TextAlign.end,
              text: explanation ?? '',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

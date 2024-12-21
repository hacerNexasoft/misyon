import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:widgets/components.dart';

class MiniCardWidget extends BaseStatelessWidget {
  final String? title;
  final String? data;
  final bool showBorder;
  const MiniCardWidget({
    super.key,
    this.title,
    this.data,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: 109.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: AppColors.grey50Color,
        border: showBorder
            ? Border.all(
                color: AppColors.primaryColor,
                width: 1.w,
              )
            : null,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleFactorAutoSizeText(
            textAlign: TextAlign.center,
            text: title ?? '',
            style: theme.primaryTextTheme.bodySmall!.semibold.copyWith(
              color: AppColors.grey700Color,
            ),
          ),
          SizedBox(height: 8.h),
          ScaleFactorAutoSizeText(
            textAlign: TextAlign.center,
            text: data,
            style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}

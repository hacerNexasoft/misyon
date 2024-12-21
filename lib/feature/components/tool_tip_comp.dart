import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info_popup/info_popup.dart';

class ToolTipWidget extends BaseStatelessWidget {
  final String infoText;
  final Color? iconColor;
  final Color? contentBackgroundColor;
  const ToolTipWidget(
      {super.key,
      required this.infoText,
      this.iconColor,
      this.contentBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return InfoPopupWidget(
      contentTitle: infoText,
      arrowTheme: InfoPopupArrowTheme(
        color: contentBackgroundColor ?? AppColors.primaryColor,
        arrowDirection: ArrowDirection.up,
      ),
      contentTheme: InfoPopupContentTheme(
        infoContainerBackgroundColor: AppColors.backgroundColor,
        infoTextStyle: theme.primaryTextTheme.bodyMedium!,
        contentPadding: EdgeInsets.all(10.w),
        contentBorderRadius:
            BorderRadius.all(Radius.circular(Get.width * 0.03)),
        infoTextAlign: TextAlign.center,
      ),
      dismissTriggerBehavior: PopupDismissTriggerBehavior.anyWhere,
      areaBackgroundColor: Colors.transparent,
      indicatorOffset: Offset.zero,
      contentOffset: Offset.zero,
      child: Icon(Icons.info,
          color: iconColor?.withOpacity(0.5) ??
              AppColors.primaryColor.withOpacity(0.5),
          size: 24.h),
    );
  }
}

import 'package:common/common.dart';

class CustomButton extends BaseStatelessWidget {
  final void Function()? onTap;
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? disabledBackgroundColor;
  final bool isEnable;
  final Widget child;
  final Color borderColor;
  final double? borderRadius;

  const CustomButton(
      {super.key,
      required this.onTap,
      this.backgroundColor,
      this.textColor,
      this.iconColor,
      this.isEnable = true,
      this.iconData,
      this.disabledBackgroundColor,
      this.borderRadius,
      this.borderColor = Colors.transparent,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * .06,
      child: ElevatedButton(
        onPressed: isEnable ? onTap : null,
        style: ElevatedButton.styleFrom(
          textStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
            color: isEnable ? textColor ?? AppColors.white : AppColors.white,
          ),
          elevation: 0,
          alignment: Alignment.center,
          disabledBackgroundColor:
              disabledBackgroundColor ?? AppColors.fillColor,
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? Get.width * .03),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: child,
      ),
    );
  }
}

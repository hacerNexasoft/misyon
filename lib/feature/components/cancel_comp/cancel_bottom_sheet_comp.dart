import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class CancelBottomSheetComp extends BaseStatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onApply;
  const CancelBottomSheetComp({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetSafeArea(
      child: Container(
        height: 250.w,
        width: Get.width,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Get.width * 0.1),
            topRight: Radius.circular(Get.width * 0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader,
            _buildSubtitle,
            _buildApplyButton,
          ],
        ),
      ),
    );
  }

  Widget get _buildHeader {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Align(
        alignment: Alignment.center,
        child: ScaleFactorAutoSizeText(
          text: title,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget get _buildSubtitle {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      child: ScaleFactorAutoSizeText(
        text: subtitle,
        style: theme.primaryTextTheme.bodyMedium?.copyWith(
          color: AppColors.darkGreyColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget get _buildApplyButton {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomButton(
            onTap: onApply,
            backgroundColor: AppColors.primaryColor,
            borderRadius: Get.width * 0.1,
            child: ScaleFactorAutoSizeText(
              text: 'Devam Et',
              style: theme.primaryTextTheme.bodyLarge!.copyWith(
                color: AppColors.backgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomButton(
            onTap: () => Get.back(),
            backgroundColor: AppColors.secondaryPinkColor,
            borderRadius: Get.width * 0.1,
            child: ScaleFactorAutoSizeText(
              text: 'Vazgeç',
              style: theme.primaryTextTheme.bodyLarge!.copyWith(
                color: AppColors.darkTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

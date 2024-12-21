import 'package:common/common.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/project_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:widgets/components.dart';

class ProjectCompletedComp extends BaseStatelessWidget {
  final ProjectModel projectModel;
  const ProjectCompletedComp({
    super.key,
    required this.projectModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.sp,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(Get.width * 0.07),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGreyColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _imageWithText,
          _fundCollectedRow,
          SizedBox(
            height: 5.sp,
          ),
          _fundingRateRow
        ],
      ),
    );
  }

  Widget get _imageWithText => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ProjectCustomCachedNetworkImageComp(
            imageUrl: projectModel.imageUrl,
            size: 30.sp,
            isCircular: true,
            fit: BoxFit.contain,
          ),
          ScaleFactorAutoSizeText(
            text: projectModel.ownerName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.primaryTextTheme.bodyLarge!.copyWith(
              color: AppColors.darkTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );

  Widget get _fundCollectedRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScaleFactorAutoSizeText(
            text: LocalizationKeys.fundsCollectedKey.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.primaryTextTheme.bodyMedium!.copyWith(
              color: AppColors.grey500Color,
            ),
          ),
          Flexible(
            child: ScaleFactorAutoSizeText(
              text: projectModel.completedAmount,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.primaryTextTheme.bodyLarge!.copyWith(
                color: AppColors.darkTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );

  Widget get _fundingRateRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScaleFactorAutoSizeText(
            text: LocalizationKeys.fundingRatioKey.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.primaryTextTheme.bodyMedium!.copyWith(
              color: AppColors.grey500Color,
            ),
          ),
          Flexible(
            child: ScaleFactorAutoSizeText(
              text: Formatter.formatPercent(projectModel.completedTargetRate),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.primaryTextTheme.bodyLarge!.copyWith(
                color: AppColors.grey1000Color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
}

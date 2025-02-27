import 'package:common/common.dart';
import 'package:intl/intl.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/models/project/project_model.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:widgets/components.dart';

import '../../../product/config/routes/app_views.dart';

class ProjectCompletedComp extends BaseStatelessWidget {
  final ProjectModel projectModel;
  const ProjectCompletedComp({
    super.key,
    required this.projectModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (projectModel.status != ProjectStatus.upcomingPreview &&
            projectModel.status != ProjectStatus.upcomingPrerelease &&
            projectModel.status != ProjectStatus.unknown) {
          Get.toNamed(AppRoutes.detailView, arguments: {
            'project': projectModel,
          });
        }
      },
      child: Container(
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
      ),
    );
  }

  Widget get _imageWithText => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ProjectCustomCachedNetworkImageComp(
            imageUrl: projectModel.logoUrl,
            size: 30.sp,
            isCircular: true,
            fit: BoxFit.contain,
          ),
          Expanded(
            child: ScaleFactorAutoSizeText(
              text: projectModel.title,
              maxLines: 1,
              minFontSize: 8,
              maxFontSize: 18,
              overflow: TextOverflow.ellipsis,
              style: theme.primaryTextTheme.bodyLarge!.copyWith(
                color: AppColors.darkTextColor,
                fontWeight: FontWeight.w600,
              ),
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
              text: "${NumberFormat.decimalPattern('tr').format(projectModel.fundedAmount)} TL",
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
              text: Formatter.formatPercent(projectModel.fundingPercentage),
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

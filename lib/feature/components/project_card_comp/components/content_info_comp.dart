part of '../project_card_comp.dart';

class _ContentInfoComp extends BaseStatelessWidget {
  final ProjectModel projectModel;

  const _ContentInfoComp({
    required this.projectModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (projectModel.status != ProjectStatus.upcomingPreview &&
            projectModel.status != ProjectStatus.upcomingPrerelease &&
            projectModel.status != ProjectStatus.unknown) {
          Get.toNamed(AppRoutes.detailView, arguments: {
            'project': projectModel,
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _infoHeader,
              SizedBox(
                height: 5.sp,
              ),
              innerContextSelector(projectModel.status),
              SizedBox(
                height: 5.sp,
              ),
              _infoBottomRow,
            ],
          ),
        ),
      ),
    );
  }

  Widget innerContextSelector(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.activeFunding:
        return _context1;
      case ProjectStatus.activeFundingStopped:
        return _context1;
      case ProjectStatus.successful:
        return _context1;
      case ProjectStatus.upcomingPreview:
        return _context2;
      case ProjectStatus.upcomingPrerelease:
        return _context2;
      case ProjectStatus.upcomingDetailedPrerelease:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }

  Widget get _infoHeader => Row(
        children: [
          // if (projectModel.amountReceived == null)
          ProjectCustomCachedNetworkImageComp(
            imageUrl: projectModel.coverImage,
            size: 32.w,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.zero.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ScaleFactorAutoSizeText(
                          text: projectModel.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.primaryTextTheme.bodyMedium!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      /*Flexible(
                        child: ScaleFactorAutoSizeText(
                          text: Formatter.formatMoney(
                            projectModel.fundedAmount.toString(),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.primaryTextTheme.bodyMedium!.copyWith(
                            color: AppColors.subTitleGreyColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),*/
                    ],
                  ),
                  ScaleFactorAutoSizeText(
                    text: projectModel.shortDescription,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.primaryTextTheme.bodySmall
                        ?.copyWith(color: AppColors.subTitleGreyColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget get _context1 {
    String periodText = "-";
    switch (projectModel.period) {
      case Period.Annual:
        periodText = LocalizationKeys.periodAnnualyTextKey.tr;
        break;
      case Period.Monthly:
        periodText = LocalizationKeys.periodMonthlyTextKey.tr;
        break;
      default:
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _valueItem(
          title: LocalizationKeys.earningFrequencyTextKey.tr,
          value: periodText,
        ),
        _valueItem(
          title: LocalizationKeys.termTextKey.tr,
          value: '${projectModel.termCode} Ay',
        ),
        _valueItem(
          title: LocalizationKeys.earningRateTextKey.tr,
          value: '%${projectModel.yearlyReturnRate}',
        ),
      ],
    );
  }

  Widget get _context2 {
    final DateFormat dateformatter = DateFormat('dd MMM yyyy');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _valueItem(
          title: LocalizationKeys.startDateTextKey.tr,
          value: dateformatter
              .format(DateTime.fromMillisecondsSinceEpoch(projectModel.projectStartDate * 1000)),
        ),
        _valueItem(
          title: LocalizationKeys.earningRateTextKey.tr,
          value: Formatter.formatPercent(projectModel.yearlyReturnRate),
        ),
      ],
    );
  }

  Widget _valueItem({
    required String value,
    required String title,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleFactorAutoSizeText(
                  text: title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.primaryTextTheme.labelLarge
                      ?.copyWith(color: AppColors.darkGreyColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                ScaleFactorAutoSizeText(
                  text: value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.primaryTextTheme.bodyLarge!.copyWith(
                    color: AppColors.warmGrayColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget get _infoBottomRow => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (projectModel.riskForDebit != null &&
              projectModel.status != ProjectStatus.upcomingDetailedPrerelease)
            _riskRatio, // Risk Kısmı burada
          SizedBox(
            height: 16.w,
          ),

          Flexible(child: _categoryChips),
        ],
      );
  Widget get _riskRatio => Row(
        children: [
          ScaleFactorAutoSizeText(
            text: LocalizationKeys.riskTextKey.tr,
            style: theme.primaryTextTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.bold, color: AppColors.darkGreyColor),
          ),
          SizedBox(
            width: 8.w,
          ),
          Container(
            width: 22.sp,
            height: 12.sp,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r), color: projectModel.riskForDebit!.color),
          )
        ],
      );

  Widget get _categoryChips {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: Get.height * 0.004),
          decoration: BoxDecoration(
            color: AppColors.fillColor,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: ScaleFactorAutoSizeText(
            text: projectModel.category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.primaryTextTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreyColor,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: Get.height * 0.004),
          decoration: BoxDecoration(
            color: AppColors.fillColor,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: ScaleFactorAutoSizeText(
            text: ModelHelpers.localizedCollateralStructure(projectModel.collateralStructure),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.primaryTextTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreyColor,
            ),
          ),
        ),
      ]),
    );
  }
}

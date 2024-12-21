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
        Get.toNamed(AppRoutes.detailView, arguments: {
          'projectName': projectModel.ownerName,
        });
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
              if (projectModel.amountReceived != null) ...[],
              _infoHeader,
              SizedBox(
                height: 5.sp,
              ),
              projectModel.status == ProjectStatus.preDemand
                  ? const SizedBox()
                  : (projectModel.status == ProjectStatus.upcoming
                      ? _upcomingValues
                      : _values),
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

  Widget get _infoHeader => Row(
        children: [
          if (projectModel.amountReceived == null)
            ProjectCustomCachedNetworkImageComp(
              imageUrl: projectModel.imageUrl,
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
                          text: projectModel.ownerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.primaryTextTheme.bodyMedium!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (projectModel.amountReceived != null)
                        Flexible(
                          child: ScaleFactorAutoSizeText(
                            text: Formatter.formatMoney(
                              projectModel.amountReceived.toString(),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.primaryTextTheme.bodyMedium!.copyWith(
                              color: AppColors.subTitleGreyColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  ScaleFactorAutoSizeText(
                    text: projectModel.shortDesc,
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

  Widget get _values => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (projectModel.earningFrequency != null)
            _valueItem(
              title: LocalizationKeys.earningFrequencyTextKey.tr,
              value: projectModel.earningFrequency ?? '-',
            ),
          if (projectModel.maturity != null)
            _valueItem(
              title: LocalizationKeys.maturityTextKey.tr,
              value: '${projectModel.maturity} Ay',
            ),
          if (projectModel.earningRate != null)
            _valueItem(
              title: LocalizationKeys.earningRateTextKey.tr,
              value: '%${projectModel.earningRate}',
            ),
        ],
      );

  Widget get _upcomingValues => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _valueItem(
            title: LocalizationKeys.startDateTextKey.tr,
            value: '${projectModel.startDate}',
          ),
          _valueItem(
            title: LocalizationKeys.earningRateTextKey.tr,
            value: '%${projectModel.earningRate}',
          ),
        ],
      );

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
                  style: theme.primaryTextTheme.labelLarge?.copyWith(
                      color: AppColors.darkGreyColor,
                      fontWeight: FontWeight.w600),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (projectModel.status != ProjectStatus.preDemand) _riskRatio,
          SizedBox(
            height: 16.w,
          ),
          _categoryChips,
        ],
      );
  Widget get _riskRatio => Row(
        children: [
          ScaleFactorAutoSizeText(
            text: LocalizationKeys.riskTextKey.tr,
            style: theme.primaryTextTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.darkGreyColor),
          ),
          SizedBox(
            width: 8.w,
          ),
          Container(
            width: 22.sp,
            height: 12.sp,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: projectModel.riskType!.color),
          )
        ],
      );

  Widget get _categoryChips => Flexible(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: projectModel.categories != null
                ? projectModel.categories!.map((category) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: Get.height * 0.004),
                      decoration: BoxDecoration(
                        color: AppColors.fillColor,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: ScaleFactorAutoSizeText(
                        text: category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.primaryTextTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGreyColor,
                        ),
                      ),
                    );
                  }).toList()
                : [],
          ),
        ),
      );
}

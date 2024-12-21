part of '../../navbar_view.dart';

class _NavbarAppBarInfoWidget extends BaseStatelessWidget {
  final controller = Get.find<NavbarViewController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.w, left: 10.w, bottom: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bottomArea,
              _chartIcon,
            ],
          ),
        ],
      ),
    );
  }

  Widget get _bottomArea => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bottomHeader,
            _priceArea,
            _changeValuesArea,
          ],
        ),
      );

  Widget get _bottomHeader => Row(
        children: [
          ScaleFactorAutoSizeText(
            text: LocalizationKeys.myAlternativeExistanceTextKey.tr,
            style: theme.primaryTextTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextColor,
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.visibility_outlined,
              color: AppColors.backgroundColor.withOpacity(0.5),
            ),
          ),
        ],
      );

  Widget get _priceArea => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ScaleFactorAutoSizeText(
            text: '51.896,76',
            style: theme.primaryTextTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextColor,
            ),
          ),
          SizedBox(width: 5.w),
          ScaleFactorAutoSizeText(
            text: 'TL',
            style: theme.primaryTextTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextColor,
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.expand_less,
                  color: AppColors.backgroundColor,
                  size: 16.w,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.expand_more,
                  color: AppColors.backgroundColor,
                  size: 16.w,
                ),
              ),
            ],
          ),
        ],
      );

  Widget get _changeValuesArea => Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.arrow_drop_up,
              color: AppColors.backgroundColor,
            ),
          ),
          ScaleFactorAutoSizeText(
            text: '1.089,82',
            style: theme.primaryTextTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextColor,
            ),
          ),
          SizedBox(width: 5.w),
          ScaleFactorAutoSizeText(
            text: '(%2.1)',
            style: theme.primaryTextTheme.bodyMedium!.copyWith(
              color: AppColors.lightTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5.w),
          Icon(Icons.circle, color: AppColors.backgroundColor, size: 5.w),
          SizedBox(width: 5.w),
          ScaleFactorAutoSizeText(
            text: 'Tümü',
            style: theme.primaryTextTheme.bodyMedium!.copyWith(
              color: AppColors.lightTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  Widget get _chartIcon => InkWell(
        onTap: () {
          Get.dropdownBottomSheet(
              child: AssetVolumeChartWidget(controller.investmentsItemList));
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(999.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 10.w),
          child: _buildIcon(
            assetPath: AssetConstants.pieChartIcon,
            onTap: () {},
          ),
        ),
      );

  Widget _buildIcon({required String assetPath, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(assetPath),
    );
  }
}

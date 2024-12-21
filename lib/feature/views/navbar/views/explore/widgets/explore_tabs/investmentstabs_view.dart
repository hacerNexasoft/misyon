part of '../../explore_view.dart';

class InvestmentsTabView extends BaseGetView<ExploreViewController> {
  const InvestmentsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchRowComp(
            rightIcon: AssetConstants.filterIcon,
            leftIcon: AssetConstants.searchComp,
            onRightIconTap: () => Get.toNamed(AppRoutes.filterCommunitiesView),
            onLeftIconTap: () => controller.sortingShowBottomSheet(),
          ),
          SizedBox(height: 10.h),
          ScaleFactorAutoSizeText(
            text: LocalizationKeys.recentInvestmentsTextKey.tr,
            style: theme.primaryTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
          SizedBox(height: 10.h),
          controller.obx((state) => InvestmentsListWidget(),
              onLoading: const LoadingWidget(),
              onEmpty: EmptyWidget(
                  image: AssetConstants.emptyItemIcon,
                  text: "Hata!!!",
                  size: 30.sp),
              onError: (error) => CustomErrorWidget(
                    text: "Beklenmedik bir hata çıktı!!!",
                    image: AssetConstants.emptyItemIcon,
                    onRetry: controller.fetchRecentInvestments,
                  )),
        ],
      ),
    );
  }
}

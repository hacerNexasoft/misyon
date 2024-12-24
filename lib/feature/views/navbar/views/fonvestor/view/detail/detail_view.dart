import 'package:common/common.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misyonbank/feature/components/tabbar/underlined_tab_bar_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/detail_view_controller.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/services/jwt_token_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'widgets/detail_top_widget.dart';

class DetailView extends BaseGetView<DetailViewController> {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: 80.h,
        width: Get.width,
        color: AppColors.backgroundColor,
        child: _buildMakeanInvestment,
      ),
      body: controller.obx(
        (state) => _buildContent(),
        onLoading: const LoadingWidget(),
        onError: (error) => CustomErrorWidget(
          text: LocalizationKeys.tryAgainTextKey.tr,
          onRetry: controller.initView,
        ),
        onEmpty: EmptyWidget(
          image: AssetConstants.emptyItemIcon,
          text: LocalizationKeys.emptySearchTextKey.tr,
          size: 12.h,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: AppColors.backgroundColor,
            scrolledUnderElevation: 0,
            iconTheme: const IconThemeData(color: AppColors.black),
            title: Center(
              child: ScaleFactorAutoSizeText(
                text: LocalizationKeys.detailTitleTextKey.tr,
                style: theme.primaryTextTheme.bodyLarge?.semibold,
              ),
            ),
            collapsedHeight: 70.h,
            expandedHeight: 480.h,
            flexibleSpace: FlexibleSpaceBar(
              background: DetailTopWidget(),
            ),
            pinned: true,
            floating: false,
            snap: false,
            actions: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: SvgPicture.asset(
                    AssetConstants.starIcon,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: SvgPicture.asset(
                    AssetConstants.shareIcon,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.h),
              child: UnderlinedTabBarComp(
                changeTab: controller.changeTab,
                tabController: controller.tabController,
                tabTitles: controller.tabs,
                physics: const BouncingScrollPhysics(),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: controller.tabController,
        physics: const BouncingScrollPhysics(),
        children: controller.detailsTabbarList,
      ),
    );
  }

  Widget get _buildMakeanInvestment => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleFactorAutoSizeText(
                  text: LocalizationKeys.detailsdayTextKey.tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                    color: AppColors.primaryGreyColor,
                  ),
                ),
                ScaleFactorAutoSizeText(
                  text: LocalizationKeys.detailsdaysTextKey.tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                    color: AppColors.primaryGreyColor,
                  ),
                ),
              ],
            ),
            SizedBox(width: 50.w),
            Flexible(
              child: CustomButton(
                borderRadius: 999.r,
                onTap: () {
                  final jwtTokenService = Get.find<JwtTokenService>();
                  if (jwtTokenService.jwtToken != null) {
                    Get.toNamed(AppRoutes.investView,
                        arguments: controller.projectDetailModel.value);
                  } else {
                    Get.toNamed(AppRoutes.signInView,
                        arguments: controller.projectDetailModel.value);
                  }
                },
                child: ScaleFactorAutoSizeText(
                  text: LocalizationKeys.investTextKey.tr,
                  style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

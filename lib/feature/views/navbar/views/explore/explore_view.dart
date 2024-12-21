import 'package:common/common.dart';
import 'package:misyonbank/feature/components/search_row_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/explore/explore_view_controller.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/utils/extensions.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

part 'widgets/explore_tabs/update_list_widget.dart';
part 'widgets/explore_tabs/investments_list_item_widget.dart';
part 'widgets/explore_tabs/investments_list_widget.dart';
part 'widgets/explore_tabs/investmentstabs_view.dart';
part 'widgets/explore_tabs/update_view.dart';
part 'widgets/explore_tabs/update_list_item_widget.dart';

class ExploreView extends BaseGetView<ExploreViewController> {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.w),
      child: Column(
        children: [
          _buildTabBar(),
          Expanded(child: _buildTabBarView()),
        ],
      ),
    );
  }

  Padding _buildTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: TabBar(
        tabs: List.generate(
          controller.communityViewTabs.length,
          (index) => Tab(
            text: controller.communityViewTabs[index],
          ),
        ),
        controller: controller.tabController,
        onTap: controller.changeTab,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: AppColors.primaryColor,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 10.w),
        indicatorWeight: 0.1,
        padding: EdgeInsets.zero,
        tabAlignment: TabAlignment.start,
        splashFactory: NoSplash.splashFactory,
        isScrollable: true,
        labelStyle: theme.primaryTextTheme.bodyMedium!
            .copyWith(color: AppColors.black, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            theme.primaryTextTheme.bodyMedium?.copyWith(color: AppColors.primaryGreyColor),
      ),
    );
  }

  Widget _buildTabBarView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.w),
      child: TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: controller.tabController,
        children: const [InvestmentsTabView(), UpdateView()],
      ),
    );
  }
}

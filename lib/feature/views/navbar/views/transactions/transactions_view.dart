import 'package:common/common.dart';
import 'package:misyonbank/feature/components/search_row_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/transactions_view_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/view/filtering_transactions_view.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/models/investment_model.dart';
import 'package:misyonbank/product/models/project_model.dart';
import 'package:misyonbank/product/utils/extensions.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'transactions_list_actuals_widget/transactions_list_actuals_item_widget.dart';
part 'transactions_list_actuals_widget/transactions_lis_actuals_widget.dart';
part 'pending_transactions_list_widget/pending_transactions_list_widget.dart';
part 'pending_transactions_list_widget/pending_transactions_list_item_widget.dart';
part 'canceled_transactions_list_widget/canceled_transactions_list_widget.dart';
part 'canceled_transactions_list_widget/canceled_transactions_list_item_widget.dart';

class TransactionsView extends BaseGetView<TransactionsViewController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: Column(
        children: [
          _buildTabBar(),
          _searchBar,
          _buildTabBarView(),
        ],
      ),
    );
  }

  Widget get _searchBar => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: SearchRowComp(
          leftIcon: AssetConstants.filterIcon,
          onLeftIconTap: () => Get.to(const FilteringTransactionsView()),
        ),
      );
  Padding _buildTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: TabBar(
        tabs: List.generate(controller.tabs.length,
            (index) => Tab(text: controller.tabs[index])),
        controller: controller.tabController,
        onTap: controller.onTabSelected,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: AppColors.primaryColor,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 20.w),
        indicatorWeight: 0.1,
        padding: EdgeInsets.zero,
        tabAlignment: TabAlignment.start,
        splashFactory: NoSplash.splashFactory,
        isScrollable: true,
        labelStyle:
            theme.primaryTextTheme.bodyLarge!.copyWith(color: AppColors.black),
        unselectedLabelStyle: theme.primaryTextTheme.bodyLarge
            ?.copyWith(color: AppColors.primaryGreyColor),
      ),
    );
  }

  Expanded _buildTabBarView() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.w),
        child: TabBarView(
          controller: controller.tabController,
          children: const [
            _TransactionsActualsListWidget(),
            _PendingTransactionsListWidget(),
            _CanceldTransactionsListWidget(),
          ],
        ),
      ),
    );
  }
}

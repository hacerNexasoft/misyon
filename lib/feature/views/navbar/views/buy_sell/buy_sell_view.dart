import 'package:common/common.dart';
import 'package:misyonbank/feature/components/project_card_comp/project_card_comp.dart';
import 'package:misyonbank/feature/components/search_row_comp.dart';
import 'package:misyonbank/feature/components/tabbar/cupertino_tab_bar_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/buy_sell/buy_sell_view_controller.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'widgets/buy_sell_list_widget.dart';

class BuySellView extends BaseGetView<BuySellViewController> {
  const BuySellView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
      child: Column(
        children: [
          CupertinoTabBarComp(
            changeTab: controller.changeTab,
            tabController: controller.tabController,
            tabs: controller.tabs,
          ),
          _searchBar,
          _buildList,
        ],
      ),
    );
  }

  Widget get _searchBar => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: const SearchRowComp(
          leftIcon: AssetConstants.filterIcon,
        ),
      );

  Widget get _buildList => controller.obx(
        (_) => _BuySellListWidget(),
        onLoading: const LoadingWidget(),
        onEmpty: EmptyWidget(
          image: AssetConstants.emptyItemIcon,
          text: LocalizationKeys.emptySearchTextKey.tr,
          size: 75.h,
        ),
        onError: (error) => ScaleFactorAutoSizeText(text: error.toString()),
      );
}

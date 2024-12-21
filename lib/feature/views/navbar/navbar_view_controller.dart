import 'package:common/common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/fonvestor_view_binding.dart';
import 'package:misyonbank/feature/views/navbar/views/buy_sell/buy_sell_view_binding.dart';
import 'package:misyonbank/feature/views/navbar/views/explore/explore_view_binding.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/investments_view.dart';
import 'package:misyonbank/feature/views/navbar/views/buy_sell/buy_sell_view.dart';
import 'package:misyonbank/feature/views/navbar/views/explore/explore_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/fonvestor_view.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/investments_view_binding.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/transactions_view.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/transactions_view_binding.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/widget_models/investments_item_model.dart';
import 'package:misyonbank/product/services/project_service.dart';

class NavbarViewController extends BaseGetxController
    with GetTickerProviderStateMixin {
  final RxInt selectedIndex = 2.obs;
  var isAppBarExpanded = true.obs;
  @override
  void onInit() async {
    await initView();
    super.onInit();
  }

  final _projectService = Get.put(ProjectService());
  RxList<InvestmentsItemModel?> get investmentsItemList =>
      _projectService.investmentsItemList;
  final List<String> routes = const [
    AppRoutes.investments,
    AppRoutes.transactions,
    AppRoutes.fonvestor,
    AppRoutes.buySell,
    AppRoutes.community,
  ];

  final List<Map<String, dynamic>> navBarViews = [
    {"route": AppRoutes.investments, "appbarTitle": null},
    {
      "route": AppRoutes.transactions,
      "appbarTitle": LocalizationKeys.transactionsTextKey.tr
    },
    {"route": AppRoutes.fonvestor, "appbarTitle": null},
    {
      "route": AppRoutes.buySell,
      "appbarTitle": LocalizationKeys.buySellTextKey.tr
    },
    {
      "route": AppRoutes.community,
      "appbarTitle": LocalizationKeys.communityTextKey.tr
    },
  ];

  List<BottomNavigationBarItem> get bottomNavigationBarItems => [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetConstants.investmentsIcon),
          activeIcon: SvgPicture.asset(
            AssetConstants.investmentsIcon,
            colorFilter:
                const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
          label: LocalizationKeys.investmentsTextKey.tr,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetConstants.transactionsIcon),
          activeIcon: SvgPicture.asset(
            AssetConstants.transactionsIcon,
            colorFilter:
                const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
          label: LocalizationKeys.transactionsTextKey.tr,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AssetConstants.alternativeIcon,
            colorFilter: const ColorFilter.mode(
                AppColors.primaryGreyColor, BlendMode.srcIn),
          ),
          activeIcon: SvgPicture.asset(
            AssetConstants.alternativeIcon,
          ),
          label: LocalizationKeys.fonvestorTextKey.tr,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetConstants.buySellIcon),
          activeIcon: SvgPicture.asset(
            AssetConstants.buySellIcon,
            colorFilter:
                const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
          label: LocalizationKeys.buySellTextKey.tr,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetConstants.communityIcon),
          activeIcon: SvgPicture.asset(
            AssetConstants.communityIcon,
            colorFilter:
                const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
          label: LocalizationKeys.communityTextKey.tr,
        ),
      ];

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.investments:
        return GetPageRoute(
          settings: settings,
          page: () => const InvestmentsView(),
          binding: InvestmentsViewBinding(),
          transition: Transition.fadeIn,
        );
      case AppRoutes.transactions:
        return GetPageRoute(
          settings: settings,
          page: () => const TransactionsView(),
          binding: TransactionsViewBinding(),
          transition: Transition.fadeIn,
        );
      case AppRoutes.fonvestor:
        return GetPageRoute(
          settings: settings,
          page: () => const FonvestorView(),
          binding: FonvestorViewBinding(),
          transition: Transition.fadeIn,
        );
      case AppRoutes.buySell:
        return GetPageRoute(
          settings: settings,
          page: () => const BuySellView(),
          binding: BuySellViewBinding(),
          transition: Transition.fadeIn,
        );
      case AppRoutes.community:
        return GetPageRoute(
          settings: settings,
          page: () => const ExploreView(),
          binding: ExploreViewBinding(),
          transition: Transition.fadeIn,
        );
      default:
        return null;
    }
  }

  void changeView(int index) {
    if (index != selectedIndex.value) {
      isAppBarExpanded.value = routes[index] == AppRoutes.fonvestor ||
          routes[index] == AppRoutes.investments;

      selectedIndex.value = index;
      Get.offAndToNamed(routes[index], id: 1);
    }
    update();
  }

  void changeAppBarExpandedstatus() {
    isAppBarExpanded.value = !isAppBarExpanded.value;
    update();
  }

  Future<void> initView({Function()? action}) async {
    try {
      change(state, status: RxStatus.loading());
      await _projectService.fetchMyInvestments();

      if (investmentsItemList.isEmpty) {
        change(state, status: RxStatus.error(""));
        return;
      }
      if (investmentsItemList.isEmpty) {
        change(state, status: RxStatus.error(""));
        return;
      }
      change(state, status: RxStatus.success());
    } catch (e) {
      change(state, status: RxStatus.error(e.toString()));
      logger.e(e);
    }
  }
}

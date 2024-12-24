import 'package:common/common.dart';
import 'package:misyonbank/feature/views/auth/sign_in/sign_in_view.dart';
import 'package:misyonbank/feature/views/auth/sign_in/sign_in_view_binding.dart';
import 'package:misyonbank/feature/views/navbar/navbar_view.dart';
import 'package:misyonbank/feature/views/navbar/navbar_view_binding.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/summary/teams_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/summary/teams_view_binding.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/investment_opportunities_binding.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/investment_opportunities_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/detail_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/detail_view_binding.dart';
import 'package:misyonbank/feature/views/navbar/views/explore/views/filter_communities/filter_communities_binding.dart';
import 'package:misyonbank/feature/views/navbar/views/explore/views/filter_communities/filter_communities_view.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/views/invest/invest_view.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/views/invest/invest_view_binding.dart';
import 'package:misyonbank/feature/views/yield_calculation/yield_calculation_view.dart';
import 'package:misyonbank/feature/views/yield_calculation/yield_calculation_view_binding.dart';

part 'app_routes.dart';

class AppViews {
  static String initial = AppRoutes.landingView;

  static final routes = [
    GetPage(
      name: AppRoutes.landingView,
      page: () => const NavbarView(),
      binding: NavbarViewBinding(),
    ),
    GetPage(
      name: AppRoutes.filterCommunitiesView,
      page: () => const FilterCommunitiesView(),
      binding: FilterCommunitiesBinding(),
    ),
    GetPage(
      name: AppRoutes.yieldCalculationRoute,
      page: () => const YieldCalculationView(),
      binding: YieldCalculationViewBinding(),
    ),
    GetPage(
      name: AppRoutes.investView,
      page: () => InvestView(),
      binding: InvestViewBinding(),
    ),
    GetPage(
      name: AppRoutes.investmentOpportunities,
      page: () => const InvestmentOpportunitiesView(),
      binding: InvestmentOpportunitiesBinding(),
    ),
    GetPage(
        name: AppRoutes.detailView,
        page: () => const DetailView(),
        binding: DetailViewBinding()),
    GetPage(
        name: AppRoutes.teamsView,
        page: () => TeamsView(),
        binding: TeamsViewBinding()),
    GetPage(
        name: AppRoutes.signInView,
        page: () => const SignInView(),
        binding: SignInViewBinding()),
  ];
}

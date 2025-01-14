import 'package:common/common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misyonbank/feature/components/categories_comp/categories_comp.dart';
import 'package:misyonbank/feature/components/horizontal_product_list_comp.dart';
import 'package:misyonbank/feature/components/yield_calcuator_tool_comp/yield_calculator_tool_widget.dart';
import 'package:misyonbank/feature/components/project_card_comp/community_card_comp.dart';
import 'package:misyonbank/feature/components/project_card_comp/project_card_header_comp.dart';
import 'package:misyonbank/feature/components/project_card_comp/project_completed_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/fonvestor_view_controller.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/investment_model.dart';
import 'package:misyonbank/product/models/project_model.dart';
import 'package:misyonbank/product/models/widget_models/community_item_model.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'widgets/community_widget.dart';
part 'widgets/investment_banner_widget.dart';
part 'widgets/favorite_alternative_opportunities_comp.dart';
part 'widgets/all_alternative_opportunities_comp.dart';
part 'widgets/completed_projects_widget.dart';

class FonvestorView extends BaseGetView<FonvestorViewController> {
  const FonvestorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isReady.value
          ? ListView(
              padding: EdgeInsets.only(bottom: 20.w),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(height: 20.h),
                _InvestmentBannerWidget(
                  investmentBanner: controller.investmentBanner.cast<String>(),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FavoriteAlternativeOpportunitiesWidget(),
                      _AllAlternativeOpportunitiesWidget(),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                CategoriesComp(),
                YieldCalculatorToolWidget(isExpandable: false),
                SizedBox(height: 20.h),
                _CommunityWidget(
                  headerTitle: LocalizationKeys.communityTextKey.tr,
                  communityItemModel: controller.communityList,
                ),
                SizedBox(height: 20.h),
                HorizontalProductListComp(
                  headerTitle: LocalizationKeys.openInvestmentsKey.tr,
                  projects: controller.openInvestmentsOpportunities,
                ),
                SizedBox(height: 20.h),
                _buildPosterDesignImage(),
                SizedBox(height: 20.h),
                _CompletedProjectsWidget(
                  headerTitle: LocalizationKeys.completedProjectsTextKey.tr,
                  projects: controller.completedCollectors,
                ),
                SizedBox(height: 20.h),
                HorizontalProductListComp(
                  headerTitle: LocalizationKeys.preDemandStatusTextKey.tr,
                  projects: controller.preOrderCollectors,
                ),
                SizedBox(height: 20.h),
                HorizontalProductListComp(
                  headerTitle: LocalizationKeys.soonTextKey.tr,
                  projects: controller.upcomingCollectors,
                ),
                SizedBox(height: 20.h),
              ],
            )
          : const SizedBox.shrink();
    });
  }

  Widget _buildPosterDesignImage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Image.asset(AssetConstants.posterDesign2),
    );
  }
}

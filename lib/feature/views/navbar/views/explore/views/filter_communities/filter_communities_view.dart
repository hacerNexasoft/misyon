import 'package:common/common.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misyonbank/feature/components/check_list_item_comp.dart';
import 'package:misyonbank/feature/components/tool_tip_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/explore/views/filter_communities/filter_communities_controller.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'widgets/investment_type_selection_widget.dart';
part 'widgets/investment_range_selection_widget.dart';
part 'widgets/fund_founder_selection_widget.dart';
part 'widgets/see_community_button_widget.dart';

class FilterCommunitiesView extends BaseGetView<FilterCommunitiesController> {
  const FilterCommunitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: const IconThemeData(color: AppColors.black),
      title: ScaleFactorAutoSizeText(
          text: LocalizationKeys.filterTextKey.tr,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          )),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: SvgPicture.asset(AssetConstants.trashIcon),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() => GetBuilder<FilterCommunitiesController>(builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _InvestmentTypeSelectionWidget(),
                _InvestmentRangeSelectionWidget(),
                _FundFounderSelectionWidget(),
                _SeeCommunityButton(),
              ],
            ),
          ),
        );
      });
}

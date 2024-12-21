import 'package:common/common.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/investment_opportunities_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/views/widgets/filter_button_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/views/widgets/labels_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/views/widgets/maturity_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/views/widgets/rate_of_return.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/views/widgets/sectors_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/views/widgets/yield_frequency_widget.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class InvestmentOpportunitiesViewFiltering
    extends BaseGetView<InvestmentOpportunitiesController> {
  const InvestmentOpportunitiesViewFiltering({super.key});

  @override
  Widget build(Object context) {
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
          onTap: () {
            controller.resetAllSelected();
          },
          child: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: SvgPicture.asset(AssetConstants.trashIcon),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() =>
      GetBuilder<InvestmentOpportunitiesController>(builder: (_) {
        return const SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SectorsWidget(),
                YieldFrequencyWidget(),
                MaturityWidget(),
                RateOfReturn(),
                LabelsWidget(),
                FilterButtonWidget(),
              ],
            ),
          ),
        );
      });
}

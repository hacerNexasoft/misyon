import 'package:common/common.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/project_opportunities_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/views/widgets/filter_button_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/views/widgets/cities_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/views/widgets/term_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/views/widgets/rate_of_return.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/views/widgets/categories_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/views/widgets/period_widget.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class ProjectOpportunitiesViewFiltering extends BaseGetView<ProjectOpportunitiesController> {
  const ProjectOpportunitiesViewFiltering({super.key});

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

  Widget _buildBody() => GetBuilder<ProjectOpportunitiesController>(builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const CategoriesWidget(),
                const PeriodsWidget(),
                const TermsWidget(),
                const RateOfReturn(),
                const CitiesWidget(),
                FilterButtonWidget(
                  onClick: () {
                    controller.onClickfilterButton();
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        );
      });
}

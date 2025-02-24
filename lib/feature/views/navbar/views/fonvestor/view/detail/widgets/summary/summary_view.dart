import 'package:common/common.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:misyonbank/feature/components/yield_calcuator_tool_comp/yield_calculator_tool_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/detail_view_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/awards/awards_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/details/details_tab_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/documents_and_financials/documents_and_financials.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/frequently_asked_questions/frequently_asked_questions_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/question_and_answer/question_and_answer_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/summary/widgets/teams_details_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/summary/widgets/campaign_card_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/summary/widgets/custom_team_image_card.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/summary/widgets/mini_card_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/summary/widgets/risk_slider.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/updates/updates_view.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/models/project/project_team_model.dart';
import 'package:misyonbank/product/utils/model_helpers.dart';
import 'package:widgets/components.dart';
part 'widgets/detail_investment_widget.dart';
part 'widgets/detail_featured_widget.dart';
part 'widgets/detail_team_widget.dart';
part 'widgets/detail_campaign_info_widget.dart';
part 'widgets/detail_risk_widget.dart';
part 'widgets/detail_tags_widget.dart';

class SummaryView extends BaseGetView<DetailViewController> {
  const SummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      shrinkWrap: true,
      children: [
        DetailInvestmentWidget(),
        YieldCalculatorToolWidget(),
        SizedBox(
          height: 15.h,
        ),
        if (controller.selectedProjectHighlightsList != null &&
            controller.selectedProjectHighlightsList!.isNotEmpty)
          DetailFeaturedWidget(),
        SizedBox(
          height: 15.h,
        ),
        /*DetailRiskWidget(),
        SizedBox(
          height: 20.h,
        ),*/
        DetailTagsWidget(),
        SizedBox(
          height: 15.h,
        ),
        DetailCampaignInfoWidget(),
        SizedBox(
          height: 15.h,
        ),
        FundUtilizationWidget(),
        SizedBox(
          height: 20.h,
        ),
        if (controller.selectedProjectTeam != null) DetailTeamWidget(),
        SizedBox(
          height: 15.h,
        ),
        if (controller.selectedProjectTrophiesList != null &&
            controller.selectedProjectTrophiesList!.isNotEmpty)
          AdditionalRewardWidget(),
        SizedBox(
          height: 15.h,
        ),
        CompanyDetailWidget(),
        SizedBox(
          height: 15.h,
        ),
        if (controller.selectedProjectDetails != null &&
            controller.selectedProjectDetails!.description.isNotEmpty)
          CompanytextDetailWidget(),
        SizedBox(
          height: 15.h,
        ),
        DetailPlatformDocumentsWidget(),
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
          height: 15.h,
        ),
        IncomeStatementWidget(),
        BalanceSheetWidget(),
        SizedBox(
          height: 15.h,
        ),
        if (controller.selectedProjectFaqList != null) FrequentlyAskedQuestionsWidget(),
        SizedBox(
          height: 15.h,
        ),
        if (controller.selectedProjectUpdateList != null) UpdatesWidget(),
        SizedBox(
          height: 15.h,
        ),
        if (controller.selectedProjectCommentsList != null) const QuestionAndAnswerView(),
        SizedBox(
          height: 80.h,
        ),
      ],
    );
  }
}

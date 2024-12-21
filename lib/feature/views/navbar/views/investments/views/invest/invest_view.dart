import 'package:common/common.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misyonbank/feature/components/primary_tab_bar.dart';
import 'package:misyonbank/feature/components/search/search_comp.dart';
import 'package:misyonbank/feature/components/tabbar/cupertino_tab_bar_comp.dart';
import 'package:misyonbank/feature/components/tool_tip_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/views/invest/invest_view_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/views/invest/views/credit_card/pdf_viewer_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/views/invest/views/money_transfer_eft/views/bank_account_selection/bank_account_selection_view_binding.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/views/invest/views/money_transfer_eft/views/bank_account_selection/bank_account_selection_view_controller.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/bank_account_model.dart';
import 'package:misyonbank/product/models/bank_model.dart';
import 'package:misyonbank/product/utils/extensions.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'views/money_transfer_eft/money_transfer_eft_view.dart.dart';
part 'views/credit_card/credit_card_view.dart';
part 'views/money_transfer_eft/widgets/select_account_widget.dart';
part 'views/money_transfer_eft/widgets/invest_amount_widget.dart';
part 'views/money_transfer_eft/widgets/read_and_accept_widget.dart';
part 'views/money_transfer_eft/views/bank_account_selection/bank_account_selection_view.dart';
part 'views/money_transfer_eft/views/bank_account_selection/widgets/bank_account_list_item_widget.dart';
part 'views/money_transfer_eft/views/bank_account_selection/widgets/bank_account_header_widget.dart';
part 'views/money_transfer_eft/widgets/warnings_widget.dart';
part 'views/money_transfer_eft/widgets/content/mission_selection_content.dart';
part 'views/money_transfer_eft/widgets/content/other_selection_content.dart';
part 'views/money_transfer_eft/widgets/error_message_widget.dart';
part 'views/money_transfer_eft/views/bank_account_selection/views/bank_account_list_view.dart';
part 'views/money_transfer_eft/views/bank_account_selection/views/bank_institution_selection_view.dart';
part 'views/credit_card/widgets/content/cradi_card_selected_content.dart';
part 'views/credit_card/widgets/cradi_card_warnings_widget.dart';
part 'views/credit_card/widgets/cradi_card_invest_amount_widget.dart';
part 'views/investment_confirmation/mony_transfer_eft_investment_confirmation_view.dart';
part 'views/investment_confirmation/cradi_card_investment_confirmation_view.dart';

class InvestView extends BaseGetView<InvestViewController> {
  InvestView({super.key});

  final views = [
    _MoneyTransferEftView(),
    _CreditCardView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: const IconThemeData(color: AppColors.black),
      title: ScaleFactorText(
        text: LocalizationKeys.investTextKey.tr,
        style: theme.primaryTextTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.close,
            color: AppColors.primaryColor,
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder<InvestViewController>(
        dispose: (_) => Get.delete<InvestViewController>(),
        builder: (_) {
          return SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    _buildTabBar(),
                    _content(),
                  ],
                ),
                _buildWarningWithKeyboardAdjustment(context),
              ],
            ),
          );
        });
  }

  Widget _buildTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: CupertinoTabBarComp(
        tabController: controller.tabController!,
        changeTab: controller.changeTab,
        tabs: controller.tabs,
      ),
    );
  }

  Widget _content() {
    return Expanded(
      child: Obx(() => views[controller.selectedTabIndex.value]),
    );
  }

  Widget _buildWarningWithKeyboardAdjustment(BuildContext context) {
    return Obx(() {
      final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
      return AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: controller.showInvestAmountError
            ? _ErrorMessageWidget()
            : const SizedBox(),
      );
    });
  }
}

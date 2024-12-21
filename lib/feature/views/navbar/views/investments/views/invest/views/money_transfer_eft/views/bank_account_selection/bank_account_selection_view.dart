part of '../../../../invest_view.dart';

class _BankAccountSelectionView
    extends BaseGetView<BankAccountSelectionViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  AppBar get _buildAppBar => AppBar(
        backgroundColor: AppColors.backgroundColor,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: ScaleFactorText(
          text: LocalizationKeys.accountToWithdrawMoneyTextKey.tr,
          style: theme.primaryTextTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.close,
                color: AppColors.darkGreyColor,
              ))
        ],
        centerTitle: true,
      );

  Widget get _buildBody => GetBuilder<BankAccountSelectionViewController>(
      autoRemove: false,
      builder: (_) {
        return Column(
          children: [
            PrimaryTabBar(
              tabs: controller.accountSelectionTabs,
              tabController: controller.tabController!,
              onTabSelected: controller.onTabChanged,
              dividerColor: AppColors.dividerColor,
            ),
            Flexible(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  _BankAccountListView(),
                  _BankAccountListView(),
                  _BankInstitutionSelectionView(),
                ],
              ),
            ),
          ],
        );
      });
}

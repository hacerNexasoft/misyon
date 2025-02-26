part of '../transactions_view.dart';

class _ComplatedInvestmentListWidget extends BaseGetView<TransactionsViewController> {
  const _ComplatedInvestmentListWidget();

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      List<InvestmentModel> filteredInvestmentList = [];
      if (controller.searchText.isNotEmpty) {
        filteredInvestmentList = controller.completedInvestmentsList
            .where((element) =>
                element.project.title.toLowerCase().contains(controller.searchText.toLowerCase()))
            .toList();
      }

      return ListView(
        padding: EdgeInsets.only(top: 15.w),
        children: controller
            .groupByDate(controller.searchText.isNotEmpty
                ? filteredInvestmentList
                : controller.completedInvestmentsList)
            .entries
            .toList()
            .asMap()
            .entries
            .map((groupEntry) => _buildTransactionGroup(
                  groupEntry.value.key,
                  groupEntry.value.value,
                  groupEntry.key,
                ))
            .toList(),
      );
    },
        onLoading: const LoadingWidget(),
        onEmpty: EmptyWidget(image: AssetConstants.emptyItemIcon, text: "Hata", size: 100.w),
        onError: (error) => CustomErrorWidget(
              text: "Hata",
              image: AssetConstants.emptyItemIcon,
              size: 100.w,
              onRetry: controller.initView,
            ));
  }

  Widget _buildTransactionGroup(String date, List<InvestmentModel> investmentList, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDateTitle(date),
        _buildDivider(),
        for (int i = 0; i < investmentList.length; i++) ...[
          _TransactionsListItemWidget(investment: investmentList[i]),
          if (i != investmentList.length - 1) _buildDivider(),
        ],
        SizedBox(
          height: 20.sp,
        ),
      ],
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: AppColors.textFieldDarkFillColor,
      thickness: 0.4,
    );
  }

  Padding _buildDateTitle(String date) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ScaleFactorAutoSizeText(
        text: date,
        style: theme.primaryTextTheme.bodyMedium!.copyWith(
          color: AppColors.toolTipGreyColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

part of '../transactions_view.dart';

class _PendingTransactionsListWidget
    extends BaseGetView<TransactionsViewController> {
  const _PendingTransactionsListWidget();

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => ListView(
        padding: EdgeInsets.only(top: 15.w),
        children: controller
            .groupByDate(controller.pendingTransactionList
                .where((transaction) => transaction != null)
                .cast<ProjectModel>()
                .toList())
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
      ),
      onLoading: const LoadingWidget(),
      onEmpty: EmptyWidget(
          image: AssetConstants.emptyItemIcon, text: "Hata", size: 100.w),
      onError: (error) => CustomErrorWidget(
        text: "Hata",
        image: AssetConstants.emptyItemIcon,
        size: 100.w,
        onRetry: controller.initView,
      ),
    );
  }

  Widget _buildTransactionGroup(
      String date, List<ProjectModel> transactions, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDateTitle(date),
        _buildDivider(),
        ...transactions.map(
          (item) => _PendingTransactionsListItemWidget(projectModel: item),
        ),
        SizedBox(height: 15.sp),
        if (index < controller.textPendingTransactions.length)
          _buildDescription(controller.textPendingTransactions[index]),
        SizedBox(height: 15.sp),
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
        text: Formatter.formatDateTime(date),
        style: theme.primaryTextTheme.bodyMedium!.copyWith(
          color: AppColors.toolTipGreyColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding _buildDescription(String description) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ScaleFactorAutoSizeText(
        text: description,
        style: theme.primaryTextTheme.bodyMedium!.copyWith(
          color: AppColors.darkGreyColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

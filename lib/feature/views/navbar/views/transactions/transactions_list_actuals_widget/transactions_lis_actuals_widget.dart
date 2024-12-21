part of '../transactions_view.dart';

class _TransactionsActualsListWidget
    extends BaseGetView<TransactionsViewController> {
  const _TransactionsActualsListWidget();

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => ListView(
              padding: EdgeInsets.only(top: 15.w),
              children: controller
                  .groupByDate(controller.realizedTransactionList
                      .where((transaction) => transaction != null)
                      .cast<ProjectModel>()
                      .toList())
                  .entries
                  .map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDateTitle(entry.key),
                    _buildDivider(),
                    ...entry.value.map((item) =>
                        _TransactionsListItemWidget(projectModel: item)),
                    SizedBox(
                      height: 20.sp,
                    ),
                  ],
                );
              }).toList(),
            ),
        onLoading: const LoadingWidget(),
        onEmpty: EmptyWidget(
            image: AssetConstants.emptyItemIcon, text: "Hata", size: 100.w),
        onError: (error) => CustomErrorWidget(
              text: "Hata",
              image: AssetConstants.emptyItemIcon,
              size: 100.w,
              onRetry: controller.initView,
            ));
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
}

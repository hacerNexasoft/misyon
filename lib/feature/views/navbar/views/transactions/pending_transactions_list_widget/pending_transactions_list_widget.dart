part of '../transactions_view.dart';

class _PendingInvestmentListWidget extends BaseGetView<TransactionsViewController> {
  const _PendingInvestmentListWidget();

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        List<InvestmentModel> filteredInvestmentList = [];
        if (controller.investmentListFilter != null) {
          filteredInvestmentList = controller.investmentListFilter!.filtereedWaitingInvestmentsList;
        }
        if (controller.searchText.isNotEmpty) {
          filteredInvestmentList = controller.waitingInvestmentsList
              .where((element) =>
                  element.project.title.toLowerCase().contains(controller.searchText.toLowerCase()))
              .toList();
        }
        return ListView(
          padding: EdgeInsets.only(top: 15.w),
          children: controller
              .groupByDate(
                  controller.searchText.isNotEmpty || controller.investmentListFilter != null
                      ? filteredInvestmentList
                      : controller.waitingInvestmentsList)
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
      ),
    );
  }

  Widget _buildTransactionGroup(String date, List<InvestmentModel> investmentList, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDateTitle(date),
        _buildDivider(),
        for (int i = 0; i < investmentList.length; i++) ...[
          GestureDetector(
              onTap: () {
                ProjectModel? projectModel =
                    controller.bringProjectModel(investmentList[i].project.id);
                if (projectModel != null && projectModel.isClickable) {
                  Get.toNamed(AppRoutes.detailView, arguments: {
                    'project': projectModel,
                  });
                }
              },
              child: _PendingInvestmentsListItemWidget(investment: investmentList[i])),
          if (i != investmentList.length - 1) _buildDivider(),
        ],
        SizedBox(height: 15.sp),
        /* if (index < controller.textPendingTransactions.length)
          _buildDescription(controller.textPendingTransactions[index]),
        SizedBox(height: 15.sp),*/
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

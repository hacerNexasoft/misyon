part of '../documents_and_financials.dart';

class BalanceSheetWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();
  List<ProjectFinancialModel> balanceFinancials = [];
  BalanceSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    for (var e in controller.selectedProjectFinancials!) {
      if (e.finansialType == FinancialType.balance) {
        balanceFinancials.add(e);
      }
    }
    balanceFinancials.sort((a, b) => a.year.compareTo(b.year));
    controller.selectedBalanceYear.value = balanceFinancials[0].year.toString();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle,
          SizedBox(height: 10.h),
          _buildList(),
          SizedBox(height: 20.h),
          _buildBalanceSheet
        ],
      ),
    );
  }

  Widget get _buildTitle => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ScaleFactorAutoSizeText(
              text: LocalizationKeys.balanceSheetTextKey.tr,
              style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                color: AppColors.toolTipGreyColor,
              ),
            ),
          ),
          Container(
            width: Get.width,
            height: 1.h,
            color: AppColors.fillColor,
          )
        ],
      );
  Widget _buildList() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SizedBox(
          height: 40.h,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: balanceFinancials.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: _buildItem(balanceFinancials[index].year.toString()),
              );
            },
          ),
        ),
      );

  Widget _buildItem(String year) {
    return GestureDetector(
      onTap: () => controller.onSelectBalanceYear(year),
      child: Obx(() => Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            decoration: BoxDecoration(
              color: controller.selectedBalanceYear.value == year
                  ? AppColors.yield_calculator_toolColor
                  : AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ScaleFactorAutoSizeText(
              text: year,
              style: theme.primaryTextTheme.bodyLarge!.bold.copyWith(
                color: controller.selectedBalanceYear.value == year
                    ? AppColors.black
                    : AppColors.hintColor,
              ),
            ),
          )),
    );
  }

  Widget get _buildBalanceSheet {
    return Obx(() {
      ProjectFinancialModel selectedBalanceFinancials = balanceFinancials.firstWhere(
        (element) => element.year.toString() == controller.selectedBalanceYear.value,
      );
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            selectedBalanceFinancials.financialItems.length,
            (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.w),
                child: CustomIncomeWidget(
                  title: selectedBalanceFinancials
                      .financialItems[index].projectFinancialDefinitionId.value,
                  data: selectedBalanceFinancials.financialItems[index].value.toString(),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

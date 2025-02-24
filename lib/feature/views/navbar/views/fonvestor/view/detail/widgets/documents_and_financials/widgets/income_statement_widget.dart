part of '../documents_and_financials.dart';

class IncomeStatementWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();
  List<ProjectFinancialModel> incomeFinancials = [];

  IncomeStatementWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    incomeFinancials.clear();
    for (var e in controller.selectedProjectFinancials!) {
      if (e.finansialType == FinancialType.income) {
        incomeFinancials.add(e);
      }
    }
    incomeFinancials.sort((a, b) => a.year.compareTo(b.year));
    controller.selectedIncomeYear.value = incomeFinancials[0].year.toString();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle,
          SizedBox(height: 20.h),
          _buildList(),
          SizedBox(height: 20.h),
          _buildIncomeStatement
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
              text: LocalizationKeys.incomeStatementTextKey.tr,
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
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: incomeFinancials.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: _currencyItem(incomeFinancials[index].year.toString()),
              );
            },
          ),
        ),
      );

  Widget _currencyItem(String year) {
    return GestureDetector(
      onTap: () => controller.onSelectIncomeYear(year),
      child: Obx(() => Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            decoration: BoxDecoration(
              color: controller.selectedIncomeYear.value == year
                  ? AppColors.yield_calculator_toolColor
                  : AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(Get.width * 0.05),
            ),
            child: ScaleFactorAutoSizeText(
              text: year,
              style: theme.primaryTextTheme.bodyLarge!.bold.copyWith(
                color: controller.selectedIncomeYear.value == year
                    ? AppColors.black
                    : AppColors.hintColor,
              ),
            ),
          )),
    );
  }

  Widget get _buildIncomeStatement {
    return Obx(() {
      ProjectFinancialModel selectedIncomeFinancials = incomeFinancials.firstWhere(
        (element) => element.year.toString() == controller.selectedIncomeYear.value,
      );
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            selectedIncomeFinancials.financialItems.length,
            (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.w),
                child: CustomIncomeWidget(
                  title: selectedIncomeFinancials
                      .financialItems[index].projectFinancialDefinitionId.value,
                  data: selectedIncomeFinancials.financialItems[index].value.toString(),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

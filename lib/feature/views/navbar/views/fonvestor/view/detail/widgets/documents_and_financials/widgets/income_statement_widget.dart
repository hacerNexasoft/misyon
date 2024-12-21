part of '../documents_and_financials.dart';

class IncomeStatementWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  IncomeStatementWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            itemCount: controller.years.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: _currencyItem(controller.years[index]),
              );
            },
          ),
        ),
      );

  Widget _currencyItem(String years) {
    return GestureDetector(
      onTap: () => controller.onSelectYears(years),
      child: Obx(() => Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            decoration: BoxDecoration(
              color: controller.selectedyears.value == years
                  ? AppColors.yield_calculator_toolColor
                  : AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(Get.width * 0.05),
            ),
            child: ScaleFactorAutoSizeText(
              text: years,
              style: theme.primaryTextTheme.bodyLarge!.bold.copyWith(
                color: controller.selectedyears.value == years
                    ? AppColors.black
                    : AppColors.hintColor,
              ),
            ),
          )),
    );
  }

  Widget get _buildIncomeStatement => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            controller.projectDetailModel.value?.incomeStatementTitle?.length ??
                0,
            (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.w),
                child: CustomIncomeWidget(
                  title: controller
                      .projectDetailModel.value?.incomeStatementTitle?[index],
                  data: controller
                      .projectDetailModel.value?.incomeStatementData?[index]
                      .toString(),
                ),
              );
            },
          ),
        ),
      );
}

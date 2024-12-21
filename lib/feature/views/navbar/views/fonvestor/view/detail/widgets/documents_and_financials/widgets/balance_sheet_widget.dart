part of '../documents_and_financials.dart';

class BalanceSheetWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  BalanceSheetWidget({
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
            itemCount: controller.years.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: _buildItem(controller.years[index]),
              );
            },
          ),
        ),
      );

  Widget _buildItem(String years) {
    return GestureDetector(
      onTap: () => controller.onSelectYears(years),
      child: Obx(() => Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            decoration: BoxDecoration(
              color: controller.selectedyears.value == years
                  ? AppColors.yield_calculator_toolColor
                  : AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(16.r),
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

  Widget get _buildBalanceSheet => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            controller.projectDetailModel.value?.balanceSheetTitle?.length ?? 0,
            (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.w),
                child: CustomIncomeWidget(
                  title: controller
                      .projectDetailModel.value?.balanceSheetTitle?[index],
                  data: controller
                      .projectDetailModel.value?.balanceSheetData?[index]
                      .toString(),
                ),
              );
            },
          ),
        ),
      );
}

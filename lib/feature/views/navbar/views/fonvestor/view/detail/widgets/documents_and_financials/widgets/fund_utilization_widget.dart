part of '../documents_and_financials.dart';

class FundUtilizationWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  FundUtilizationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle,
          SizedBox(height: 10.h),
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
              text: LocalizationKeys.fundUtilizationTextKey.tr,
              style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                color: AppColors.toolTipGreyColor,
              ),
            ),
          ),
          Container(
            width: Get.width,
            height: 1.h,
            color: AppColors.fillColor,
          ),
          ChartComp(
            chartData: List.generate(
              controller.selectedInvestmentProjectionList!.length,
              (index) => ChartData(
                  controller.selectedInvestmentProjectionList![index].investmentProjectionName,
                  controller.selectedInvestmentProjectionList![index].investmentProjectionRate),
            )
            /*[
              ChartData('Yazılım', 50.07),
              ChartData('Satış ve Pazarlama', 21.21),
              ChartData('Personel', 12.46),
              ChartData('Ödeme Altyapısı Giderleri', 10.79),
              ChartData('Diğer Giderler', 10.2),
            ]*/
            ,
          )
        ],
      );
}

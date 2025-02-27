import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/components/chart_comp/chart_comp_controller.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/chart_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:widgets/components.dart';

class ChartComp extends StatelessWidget {
  final ChartCompController controller = Get.put(ChartCompController());
  final List<ChartData> chartData;

  ChartComp({
    super.key,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    if (chartData.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SfCircularChart(
                palette: controller.chartData,
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.category,
                    yValueMapper: (ChartData data, _) => data.value,
                    pointColorMapper: (ChartData data, _) {
                      int index = chartData.indexOf(data);

                      return controller.chartData[index % controller.chartData.length];
                    },
                    innerRadius: '85%',
                    radius: '80%',
                    cornerStyle: CornerStyle.bothCurve,
                    explode: true,
                    explodeAll: true,
                    explodeOffset: '3%',
                    animationDuration: 0,
                    onPointTap: (pointTapDetails) {
                      controller.selectedIndex.value = pointTapDetails.pointIndex!;
                    },
                  ),
                ],
              ),
              Obx(() {
                final selectedData = chartData[controller.selectedIndex.value];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleFactorAutoSizeText(
                      textAlign: TextAlign.start,
                      text: selectedData.category,
                      style: Get.theme.primaryTextTheme.bodyMedium!.copyWith(
                        color: AppColors.darkTextColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    ScaleFactorAutoSizeText(
                      textAlign: TextAlign.start,
                      text: "%${selectedData.value.toStringAsFixed(2)}",
                      style: Get.theme.primaryTextTheme.titleMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        _buildTitle,
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: chartData.length,
            itemBuilder: (context, index) {
              final data = chartData[index];
              final colorData = controller.chartData[index % controller.chartData.length];
              return Padding(
                padding: EdgeInsets.all(8.h),
                child: GestureDetector(
                  onTap: () {
                    // Liste elemanına tıklandığında ilgili grafiği seç
                    controller.selectedIndex.value = index;
                  },
                  child: Obx(
                    () {
                      final isSelected = controller.selectedIndex.value == index;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 14.sp,
                            height: 14.sp,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorData,
                            ),
                          ),
                          SizedBox(width: 10.h),
                          ScaleFactorAutoSizeText(
                            textAlign: TextAlign.start,
                            text: data.category,
                            style: Get.theme.primaryTextTheme.bodyLarge!.copyWith(
                              color:
                                  isSelected ? AppColors.darkTextColor : AppColors.toolTipGreyColor,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          const Spacer(),
                          ScaleFactorAutoSizeText(
                            textAlign: TextAlign.start,
                            text: "%${data.value.toStringAsFixed(2)}",
                            style: Get.theme.primaryTextTheme.bodyLarge!.copyWith(
                              color:
                                  isSelected ? AppColors.darkTextColor : AppColors.toolTipGreyColor,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget get _buildTitle => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScaleFactorAutoSizeText(
                  text: LocalizationKeys.dispersionTitleTextKey.tr,
                  style: Get.theme.primaryTextTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.toolTipGreyColor,
                  ),
                ),
                ScaleFactorAutoSizeText(
                  text: LocalizationKeys.dispersionRatioTitleTextKey.tr,
                  style: Get.theme.primaryTextTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            height: 1.h,
            color: AppColors.fillColor,
          )
        ],
      );
}

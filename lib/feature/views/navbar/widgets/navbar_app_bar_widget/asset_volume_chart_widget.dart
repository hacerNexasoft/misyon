import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/components/chart_comp/chart_comp.dart';
import 'package:misyonbank/product/models/chart_data_model.dart';
import 'package:misyonbank/product/models/widget_models/investments_item_model.dart';
import 'package:widgets/components.dart';

class AssetVolumeChartWidget extends BaseStatelessWidget {
  final List<InvestmentsItemModel?> investmentsItemList;

  const AssetVolumeChartWidget(this.investmentsItemList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomSheetSafeArea(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top: 10.sp),
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.w),
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitle(),
              _buildChat,
              SizedBox(height: 30.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      width: Get.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ScaleFactorAutoSizeText(
            text: "Alternatif Yatırımlar Dağılımı",
            style: theme.primaryTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Positioned(
            right: 0,
            child: InkWell(
              child: const Icon(
                Icons.close,
                color: AppColors.darkTextColor,
              ),
              onTap: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildChat {
    List<ChartData> chartData = [];

    for (var item in investmentsItemList) {
      if (item != null) {
        chartData.add(
          ChartData(
            item.companyName ?? "Bilinmiyor",
            item.rateOfReturn ?? 0.0,
          ),
        );
      }
    }

    return SizedBox(
      width: Get.width,
      child: ChartComp(
        chartData: chartData,
      ),
    );
  }
}

import 'package:common/common.dart';
import 'package:misyonbank/feature/components/tool_tip_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/investment_opportunities_controller.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class MaturityWidget extends BaseGetView<InvestmentOpportunitiesController> {
  const MaturityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvestmentOpportunitiesController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 20.h),
            _buildMaturitiesOptions(),
          ],
        ),
      );
    });
  }

  Widget _buildTitle() {
    return Row(
      children: [
        ScaleFactorAutoSizeText(
          text: LocalizationKeys.maturityKey.tr,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20.w),
        const ToolTipWidget(
          infoText: 'Maturity Information',
          iconColor: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _buildMaturitiesOptions() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20.h,
        crossAxisSpacing: Get.width * 0.05,
        childAspectRatio: 2.5,
      ),
      itemCount: controller.maturities.length,
      itemBuilder: (context, index) {
        return Obx(() {
          return GestureDetector(
            onTap: () {
              controller.selectMaturity(controller.maturities[index]);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    controller.isMaturitySelected(controller.maturities[index])
                        ? AppColors.primaryColor
                        : AppColors.borderGray,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ScaleFactorAutoSizeText(
                text: controller.maturities[index],
                style:
                    controller.isMaturitySelected(controller.maturities[index])
                        ? theme.primaryTextTheme.bodyLarge
                            ?.copyWith(color: AppColors.backgroundColor)
                        : theme.primaryTextTheme.bodyMedium,
              ),
            ),
          );
        });
      },
    );
  }
}

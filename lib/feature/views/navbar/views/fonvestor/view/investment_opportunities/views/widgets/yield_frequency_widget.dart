import 'package:common/common.dart';
import 'package:misyonbank/feature/components/tool_tip_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/investment_opportunities_controller.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class YieldFrequencyWidget
    extends BaseGetView<InvestmentOpportunitiesController> {
  const YieldFrequencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvestmentOpportunitiesController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 20.h),
            _buildDurationOptions(),
          ],
        ),
      );
    });
  }

  Widget _buildTitle() {
    return Row(
      children: [
        ScaleFactorAutoSizeText(
          text: LocalizationKeys.returnFrequencyKey.tr,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20.w),
        const ToolTipWidget(
          infoText: 'Return Frequency Information',
          iconColor: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _buildDurationOptions() {
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
      itemCount: controller.durations.length,
      itemBuilder: (context, index) {
        final duration = controller.durations[index];
        final isSelected = controller.isDurationSelected(duration);

        return GestureDetector(
          onTap: () {
            controller.selectDuration(duration);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : AppColors.borderGray,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ScaleFactorAutoSizeText(
              text: duration,
              style: isSelected
                  ? theme.primaryTextTheme.bodyMedium
                      ?.copyWith(color: AppColors.backgroundColor)
                  : theme.primaryTextTheme.bodyMedium,
            ),
          ),
        );
      },
    );
  }
}

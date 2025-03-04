import 'package:common/common.dart';
import 'package:misyonbank/feature/components/tool_tip_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/project_opportunities_controller.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class PeriodsWidget extends BaseGetView<ProjectOpportunitiesController> {
  const PeriodsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectOpportunitiesController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 20.h),
            _buildPeriodOptions(),
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
          infoText: 'Period Information',
          iconColor: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _buildPeriodOptions() {
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
      itemCount: controller.periods.length,
      itemBuilder: (context, index) {
        final duration = controller.periods[index];
        final isSelected = controller.isPeriodSelected(duration);

        return GestureDetector(
          onTap: () {
            controller.selectPeriod(duration);
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
                  ? theme.primaryTextTheme.bodyMedium?.copyWith(color: AppColors.backgroundColor)
                  : theme.primaryTextTheme.bodyMedium,
            ),
          ),
        );
      },
    );
  }
}

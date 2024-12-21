import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/transactions_view_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class LabelsWidget extends BaseGetView<TransactionsViewController> {
  const LabelsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionsViewController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 20.h),
            _buildLabelsOptions(),
            SizedBox(height: 30.h),
          ],
        ),
      );
    });
  }

  Widget _buildTitle() {
    return Row(
      children: [
        ScaleFactorAutoSizeText(
          text: "Label",
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLabelsOptions() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20.h,
        crossAxisSpacing: Get.width * 0.05,
        childAspectRatio: 2.5,
      ),
      itemCount: controller.visibleTags.length,
      itemBuilder: (context, index) {
        return Obx(() {
          final tag = controller.visibleTags[index];
          final isSelected = controller.selectedTags.contains(tag);

          return GestureDetector(
            onTap: () {
              controller.toggleTagSelection(tag);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryPinkColor
                    : AppColors.dividerColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ScaleFactorAutoSizeText(
                text: tag,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: isSelected
                    ? theme.primaryTextTheme.bodyMedium
                        ?.copyWith(color: AppColors.black)
                    : theme.primaryTextTheme.bodyMedium
                        ?.copyWith(color: AppColors.black),
              ),
            ),
          );
        });
      },
    );
  }
}

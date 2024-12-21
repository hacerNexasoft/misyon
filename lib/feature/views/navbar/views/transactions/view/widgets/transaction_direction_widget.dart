import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/transactions_view_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class TransactionDirectionWidget
    extends BaseGetView<TransactionsViewController> {
  const TransactionDirectionWidget({super.key});

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
          text: "İşlemin Yönü",
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
      itemCount: controller.transactionLdirectionList.length,
      itemBuilder: (context, index) {
        return Obx(() {
          return GestureDetector(
            onTap: () {
              controller.toggleTagSelection(
                  controller.transactionLdirectionList[index]);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: controller.selectedTags
                        .contains(controller.transactionLdirectionList[index])
                    ? AppColors.primaryPinkColor
                    : AppColors.dividerColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ScaleFactorAutoSizeText(
                text: controller.transactionLdirectionList[index],
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: controller.selectedTags
                        .contains(controller.transactionLdirectionList[index])
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

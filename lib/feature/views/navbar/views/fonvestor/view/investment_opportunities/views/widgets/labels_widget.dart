import 'package:common/common.dart';
import 'package:misyonbank/feature/components/tool_tip_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/investment_opportunities_controller.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class LabelsWidget extends BaseGetView<InvestmentOpportunitiesController> {
  const LabelsWidget({super.key});

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
            _buildLabelsOptions(),
            SizedBox(height: 30.h),
            _buildSeeAllTags(),
          ],
        ),
      );
    });
  }

  Widget _buildTitle() {
    return Row(
      children: [
        ScaleFactorAutoSizeText(
          text: LocalizationKeys.tagsKey.tr,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20.w),
        const ToolTipWidget(
          infoText: 'Labels Information',
          iconColor: AppColors.toolTipGreyColor,
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
          return GestureDetector(
            onTap: () {
              controller.toggleTagSelection(controller.visibleTags[index]);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: controller.selectedTags
                        .contains(controller.visibleTags[index])
                    ? AppColors.primaryPinkColor
                    : AppColors.borderGray,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ScaleFactorAutoSizeText(
                text: controller.visibleTags[index],
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: controller.selectedTags
                        .contains(controller.visibleTags[index])
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

  Widget _buildSeeAllTags() {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          controller.toggleShowAllTags();
        },
        child: Obx(() {
          return ScaleFactorAutoSizeText(
            text: controller.showAllTags.value
                ? LocalizationKeys.hideTagsKey.tr
                : LocalizationKeys.seeAllTagsKey.tr,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.primaryTextTheme.bodyMedium
                ?.copyWith(color: AppColors.primaryColor),
          );
        }),
      ),
    );
  }
}

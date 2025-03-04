import 'package:common/common.dart';
import 'package:misyonbank/feature/components/check_list_item_comp.dart';
import 'package:misyonbank/feature/components/tool_tip_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/project_opportunities_controller.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/widget_models/check_list_comp_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class CategoriesWidget extends BaseGetView<ProjectOpportunitiesController> {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectOpportunitiesController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 15.h),
            _buildList(),
            SizedBox(
              height: 10.h,
            ),
            _buildSeeAllSectors()
          ],
        ),
      );
    });
  }

  Widget _buildTitle() {
    return Row(
      children: [
        ScaleFactorAutoSizeText(
          text: LocalizationKeys.categoryKey.tr,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20.w),
        const ToolTipWidget(
          infoText: 'Category Information',
          iconColor: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _buildList() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          itemCount: controller.visibleCategories.length,
          itemBuilder: (context, index) {
            String sector = controller.visibleCategories[index];
            return CheckListItemComp(
              model: CheckListCompModel(
                title: sector,
                isSelected: controller.isSectorSelected(sector),
              ),
              onChanged: (isChecked) {
                controller.toggleSectorSelection(sector, isChecked!);
              },
            );
          },
        ));
  }

  Widget _buildSeeAllSectors() {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          controller.toggleShowAllCategories();
        },
        child: Obx(() => ScaleFactorAutoSizeText(
              text: controller.showAllCategories.value
                  ? LocalizationKeys.hideAllCategoriesKey.tr
                  : LocalizationKeys.seeAllCategoriesKey.tr,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
            )),
      ),
    );
  }
}

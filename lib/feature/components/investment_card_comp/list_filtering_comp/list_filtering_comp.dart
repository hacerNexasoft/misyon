import 'package:common/common.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/components/investment_card_comp/list_filtering_comp/list_filtering_comp_controller.dart';

class ListFilteringComp<T> extends BaseStatelessWidget {
  final String headerTitle;
  final List<T> items;
  final double height;
  final String Function(T item) itemLabel;
  final void Function(T?) onApply;
  final T? selectedItem;

  final ListFilteringCompController<T> controller;

  ListFilteringComp({
    required this.items,
    required this.height,
    required this.headerTitle,
    required this.itemLabel,
    required this.onApply,
    required this.selectedItem,
    super.key,
  }) : controller = Get.put(
            ListFilteringCompController<T>(selectedItem ?? items.first));

  @override
  Widget build(BuildContext context) {
    return BottomSheetSafeArea(
      child: Container(
        height: height,
        width: Get.width,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Get.width * 0.1),
            topRight: Radius.circular(Get.width * 0.1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader,
            _buildList,
            _buildApplyButton,
          ],
        ),
      ),
    );
  }

  Widget get _buildHeader {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ScaleFactorAutoSizeText(
                text: headerTitle,
                style: theme.primaryTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget get _buildList {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero.w,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(vertical: 0.w),
              child: ListTile(
                title: ScaleFactorAutoSizeText(
                  text: itemLabel(item),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.primaryTextTheme.bodyMedium!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Radio<T>(
                  value: item,
                  groupValue: controller.selectedStatus.value,
                  onChanged: (T? selected) {
                    if (selected != null) {
                      controller.onSelectStatus(selected);
                    }
                  },
                ),
                onTap: () {
                  controller.onSelectStatus(item);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _buildApplyButton {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      child: Obx(
        () => CustomButton(
          onTap: () {
            onApply(controller.selectedStatus.value);
            Get.back();
          },
          backgroundColor: controller.selectedStatus.value == null
              ? AppColors.borderGray
              : AppColors.primaryColor,
          borderRadius: Get.width * 0.1,
          child: ScaleFactorAutoSizeText(
            text: 'Uygula',
            style: theme.primaryTextTheme.bodyLarge!.copyWith(
              color: AppColors.backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

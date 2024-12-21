part of '../../investments_view.dart';

class _FilterOptionsWidget extends BaseGetView<InvestmentsViewController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: controller.filterOptions.map<Widget>((option) {
        return Obx(() {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                Expanded(
                  child: ScaleFactorAutoSizeText(
                    text: option,
                    style: theme.primaryTextTheme.bodyMedium,
                  ),
                ),
                Radio<String>(
                  activeColor: AppColors.primaryColor,
                  value: option,
                  groupValue: controller.selectedOption.value,
                  onChanged: (value) {
                    controller.selectedOption.value = value!;
                  },
                ),
              ],
            ),
          );
        });
      }).toList(),
    );
  }
}

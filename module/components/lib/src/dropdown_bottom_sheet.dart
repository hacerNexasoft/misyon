import 'package:common/common.dart';
import 'package:widgets/components.dart';

typedef ValueSelect<T> = void Function(T value);
typedef DropdownSearchItemToString<T> = String Function(T item);

class DropDownBottomSheet<T> extends BaseStatelessWidget {
  final ValueSelect<T> onSelect;
  final List<T> items;
  final T selectedItem;
  final DropdownSearchItemToString<T>? itemToString;
  final bool isRatio; // New parameter to handle radio button style

  const DropDownBottomSheet({
    super.key,
    required this.onSelect,
    required this.items,
    required this.selectedItem,
    this.itemToString,
    this.isRatio = false, // Default value is false
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetSafeArea(
      child: SafeArea(
        bottom: true,
        top: false,
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            return InkWell(
              onTap: () {
                onSelect(item);
                Get.back(result: item);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05, vertical: Get.height * 0.005),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ScaleFactorAutoSizeText(
                      text: itemToString != null ? itemToString!(item) : item.toString(),
                      style: theme.primaryTextTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: item == selectedItem ? AppColors.primaryColor : null,
                      ),
                    ),
                    if (isRatio)
                      Radio<T>(
                        value: item,
                        groupValue: selectedItem,
                        hoverColor: AppColors.fillColor,
                        onChanged: (T? value) {
                          if (value != null) {
                            onSelect(value);
                            Get.back(result: value);
                          }
                        },
                        activeColor: AppColors.primaryColor,
                        focusColor: AppColors.primaryColor,
                      )
                    else if (item == selectedItem)
                      Container(
                        padding: EdgeInsets.all(Get.height * 0.005),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          size: Get.height * 0.02,
                          color: AppColors.backgroundColor,
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

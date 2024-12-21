import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/models/widget_models/check_list_comp_model.dart';
import 'package:widgets/components.dart';

class CheckListItemComp extends BaseStatelessWidget {
  final CheckListCompModel model;
  final Function(bool?)? onChanged;
  final String? imageUrl;

  const CheckListItemComp({
    super.key,
    required this.model,
    required this.onChanged,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (imageUrl != null) ...[
            Row(
              children: [
                ProjectCustomCachedNetworkImageComp(
                  imageUrl: imageUrl,
                  size: 40.w,
                ),
                SizedBox(width: 20.w),
                ScaleFactorAutoSizeText(
                  text: model.title,
                  style: theme.primaryTextTheme.bodyMedium,
                ),
              ],
            ),
          ],
          if (imageUrl == null)
            ScaleFactorAutoSizeText(
              text: model.title,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          Checkbox(
            value: model.isSelected,
            activeColor: AppColors.primaryColor,
            focusColor: AppColors.primaryColor,
            checkColor: AppColors.primaryColor,
            side: const BorderSide(
              color: AppColors.checkboxBorderColor,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Get.width * 0.01),
            ),
            fillColor: WidgetStateProperty.all(AppColors.fillColor),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

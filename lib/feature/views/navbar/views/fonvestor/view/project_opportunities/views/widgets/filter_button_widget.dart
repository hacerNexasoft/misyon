import 'package:common/common.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class FilterButtonWidget extends BaseStatelessWidget {
  final VoidCallback onClick;
  const FilterButtonWidget({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w), child: _filterButton());
  }

  Widget _filterButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      child: CustomButton(
          onTap: onClick,
          borderRadius: Get.width * 0.1,
          child: ScaleFactorAutoSizeText(
              text: LocalizationKeys.filterTextKey.tr,
              style: theme.primaryTextTheme.bodyLarge!.semibold
                  .copyWith(color: AppColors.backgroundColor))),
    );
  }
}

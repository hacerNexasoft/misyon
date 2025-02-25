import 'package:common/common.dart';
import 'package:misyonbank/product/models/master_data_model.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCardComp extends BaseStatelessWidget {
  final Category category;
  final int index;
  const CategoryCardComp({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return _cardContent;
  }

  Color get _backgroundColor {
    final colors = [
      AppColors.grey1100Color,
      AppColors.primaryOrangeColor,
      AppColors.primaryGreyColor,
      AppColors.grey1000Color,
      AppColors.grey900Color,
      AppColors.grey800Color,
      AppColors.grey700Color,
      AppColors.grey400Color,
      AppColors.primaryColor,
      AppColors.primaryWarningColor,
      AppColors.softwareColor,
      AppColors.perfonelColor,
      AppColors.tertiaryGreyColor,
      AppColors.payoutColor,
      AppColors.darkGreyColor,
    ];
    return colors[index % colors.length];
  }

  Widget get _cardContent => Container(
        width: 108.w,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            child: ScaleFactorAutoSizeText(
              text: category.value,
              textAlign: TextAlign.center,
              minFontSize: 11,
              maxFontSize: 16,
              style: theme.primaryTextTheme.labelMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
}

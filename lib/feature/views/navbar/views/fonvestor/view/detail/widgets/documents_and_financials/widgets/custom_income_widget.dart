import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:widgets/components.dart';

class CustomIncomeWidget extends BaseStatelessWidget {
  final String? title;
  final String? data;
  const CustomIncomeWidget({
    super.key,
    this.title,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ScaleFactorAutoSizeText(
                text: title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
            ScaleFactorAutoSizeText(
              text: Formatter.formatMoney(data),
              style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                color: AppColors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        const Divider(
          color: AppColors.dividerColor,
        ),
      ],
    );
  }
}

import 'package:common/common.dart';
import 'package:misyonbank/feature/components/tool_tip_comp.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class InvestmentCardHeaderComp extends BaseStatelessWidget {
  final String headerTitile;
  const InvestmentCardHeaderComp({super.key, required this.headerTitile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: ScaleFactorAutoSizeText(
                    text: headerTitile,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.primaryTextTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                ToolTipWidget(infoText: headerTitile),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.investmentOpportunities,
                  arguments: headerTitile);
            },
            child: ScaleFactorAutoSizeText(
              text: LocalizationKeys.allTextKey.tr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.primaryTextTheme.bodyMedium!.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

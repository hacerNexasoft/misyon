import 'package:common/common.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misyonbank/feature/components/tool_tip_comp.dart';
import 'package:misyonbank/feature/components/yield_calcuator_tool_comp/yield_calculator_tool_widget_controller.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'custom_yield_text_field.dart';

class YieldCalculatorToolWidget extends BaseStatelessWidget {
  final bool isExpandable;
  final YieldCalculatorToolWidgetController controller =
      Get.put(YieldCalculatorToolWidgetController());

  YieldCalculatorToolWidget({super.key, this.isExpandable = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          isExpandable ? controller.toggleExpand() : Get.toNamed(AppRoutes.yieldCalculationRoute),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        width: Get.width,
        decoration: const BoxDecoration(
          color: AppColors.yield_calculator_toolColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScaleFactorAutoSizeText(
                    text: LocalizationKeys.yieldTextKey.tr,
                    style: theme.primaryTextTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
                _buildIcon()
              ],
            ),
            Obx(
              () => controller.isExpanded.value && isExpandable
                  ? Column(
                      children: [
                        _yieldInterest,
                        SizedBox(height: 10.h),
                        _yieldAmount,
                        SizedBox(height: 10.h),
                        _monthIncome,
                        SizedBox(height: 10.h),
                        _netIncome,
                        SizedBox(height: 10.h),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() => !isExpandable
      ? Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
          child: SvgPicture.asset(
            AssetConstants.arrowForwardIOSIcon,
            colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ))
      : Obx(() => Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
            child: SvgPicture.asset(
              controller.isExpanded.value ? AssetConstants.upIcon : AssetConstants.downIcon,
            ),
          ));

  Widget get _yieldInterest => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomYieldTextField(
              title: LocalizationKeys.yieldinterestTextKey.tr,
              textController: controller.interestRateController,
              type: '%',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              maxLength: 5,
            ),
          ),
          SizedBox(width: 30.w),
          Expanded(
            child: CustomYieldTextField(
              title: LocalizationKeys.yieldmonthTextKey.tr,
              textController: controller.monthsController,
              maxLength: 2,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
          ),
        ],
      );

  Widget get _yieldAmount => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: CustomYieldTextField(
              title: LocalizationKeys.yieldamountTextKey.tr,
              textController: controller.amountController,
              type: LocalizationKeys.yieldtypeTextKey.tr,
              inputFormatters: Formatter.moneyInputFormat(2),
              maxLength: 19,
            ),
          ),
          SizedBox(width: 30.w),
          GestureDetector(
            onTap: controller.calculate,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.primaryColor,
                ),
              ),
              child: SvgPicture.asset(
                AssetConstants.calculateIcon,
                height: 20.sp,
              ),
            ),
          ),
        ],
      );

  Widget get _monthIncome => Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 60.h,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ScaleFactorAutoSizeText(
                          text: LocalizationKeys.yieldmonthlyincomeTextKey.tr,
                          style: theme.primaryTextTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(width: 10.w),
                      const ToolTipWidget(
                        infoText: 'Aylık Kazancın',
                      ),
                    ],
                  ),
                  Flexible(
                    child: Obx(() => ScaleFactorAutoSizeText(
                        text: '+${controller.monthlyIncome.toStringAsFixed(2)}TL',
                        style: theme.primaryTextTheme.bodyMedium!.copyWith(
                          color: AppColors.primaryGreenColor,
                          fontWeight: FontWeight.bold,
                        ))),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget get _netIncome => Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 60.h,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ScaleFactorAutoSizeText(
                          text: LocalizationKeys.yieldnetincomeTextKey.tr,
                          style: theme.primaryTextTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(width: 10.w),
                      const ToolTipWidget(
                        infoText: 'Net Kazancın',
                      ),
                    ],
                  ),
                  Flexible(
                    child: Obx(() => ScaleFactorAutoSizeText(
                        text: '+${controller.netIncome.toStringAsFixed(2)}TL',
                        style: theme.primaryTextTheme.bodyMedium!.copyWith(
                          color: AppColors.primaryGreenColor,
                          fontWeight: FontWeight.bold,
                        ))),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}

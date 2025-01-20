import 'package:common/common.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misyonbank/feature/views/yield_calculation/yield_calculation_result/yield_calculation_result_view.dart';
import 'package:misyonbank/feature/views/yield_calculation/yield_calculation_view_controller.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:widgets/components.dart';

class YieldCalculationView extends BaseGetView<YieldCalculationViewController> {
  const YieldCalculationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: const IconThemeData(color: AppColors.black),
      title: ScaleFactorAutoSizeText(
        text: LocalizationKeys.yieldCalculationTitleTextKey.tr,
        style: theme.primaryTextTheme.bodyLarge?.semibold,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            generateTextField(
              label: LocalizationKeys.fundingTypeTextKey.tr,
            ),
            SizedBox(height: 10.h),
            Obx(() => generateTextField(
                  textEditingController: controller.investAmountController,
                  inputFormatters: Formatter.moneyInputFormat(2),
                  maxLength: 20,
                  label: LocalizationKeys.numberOfInvestorsTextKey.tr,
                  onChanged: controller.onInvestAmountChanged,
                  fillColor: controller.fillColor.value,
                  borderColor: controller.borderColor.value,
                  suffix: _useAllSuffixWidget,
                )),
            SizedBox(height: 10.h),
            Obx(() => _infoText(title: LocalizationKeys.yieldCalculationInfoTextKey.tr)),
            SizedBox(height: 20.h),
            Obx(() => generateTextField(
                enabled: false,
                hintText: LocalizationKeys.maturityKey.tr,
                label:
                    controller.selectedMaturity.value != 0 ? LocalizationKeys.termTextKey.tr : '',
                onTap: () async => await controller.selectMaturity(context),
                suffix: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.primaryGreyColor,
                ))),
            SizedBox(height: 10.h),
            generateTextField(
              hintText: '${LocalizationKeys.rateOfReturnKey.tr} (%)',
              inputFormatters: Formatter.moneyInputFormat(2),
              textEditingController: controller.rateController,
            ),
            const Spacer(),
            _infoText(
                title: LocalizationKeys.yieldCalculationButtonInfoText.tr, hasChangeColor: false),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: CustomButton(
                borderRadius: 30.r,
                onTap: () {
                  if (controller.validateInputs()) {
                    Get.to(const YieldCalculationResultView());
                  } else {
                    Get.snackbar(
                      'Hata', // Başlık
                      'Lütfen tüm alanları doldurun.',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: ScaleFactorAutoSizeText(
                  text: LocalizationKeys.calculateYieldTextKey.tr,
                  style: theme.primaryTextTheme.bodyLarge?.semibold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoText({required String title, bool hasChangeColor = true}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            SvgPicture.asset(
              AssetConstants.infoIcon,
              width: 16.w,
              colorFilter: hasChangeColor
                  ? ColorFilter.mode(controller.textColor.value, BlendMode.srcIn)
                  : null,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: ScaleFactorAutoSizeText(
                text: title,
                style: theme.primaryTextTheme.bodySmall?.copyWith(
                  color: hasChangeColor ? controller.textColor.value : AppColors.darkGreyColor,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      );

  Widget get _useAllSuffixWidget => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(right: 40.w),
              height: 30.h,
              width: 1.w,
              color: AppColors.checkboxBorderColor,
            ),
          ),
          ScaleFactorAutoSizeText(
            text: 'TL',
            style: theme.primaryTextTheme.bodyMedium?.copyWith(
              color: controller.textColor.value,
            ),
          ),
        ],
      );

  Widget generateTextField({
    String label = '',
    String? hintText,
    TextEditingController? textEditingController,
    void Function(String)? onChanged,
    bool enabled = true,
    void Function()? onTap,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    Color? fillColor,
    Widget? suffix,
    Color? borderColor,
  }) {
    final borderRadius = BorderRadius.circular(Get.width * 0.03);
    final hintStyle = theme.primaryTextTheme.bodyMedium?.copyWith(
      color: AppColors.darkGreyColor,
    );
    final textStyle = theme.primaryTextTheme.bodyMedium?.copyWith(
      color: AppColors.black,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: suffix != null ? EdgeInsets.only(right: 40.w) : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: fillColor ?? AppColors.textFieldFillColor,
          borderRadius: borderRadius,
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomTextField(
                filled: true,
                textEditingController: textEditingController,
                hintText: hintText,
                hintStyle: hintStyle,
                label: label,
                labelColor: textEditingController != null && textEditingController.text.isNotEmpty
                    ? controller.textColor.value
                    : null,
                contentVerticalPadding: 5,
                contentHorizontalPadding: 0,
                maxLength: maxLength,
                inputFormatters: inputFormatters,
                enabled: enabled,
                border: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.transparent,
                style: textStyle,
                onChanged: onChanged,
                keyboardType: TextInputType.text,
                onTap: onTap,
              ),
            ),
            if (suffix != null) suffix,
          ],
        ),
      ),
    );
  }
}

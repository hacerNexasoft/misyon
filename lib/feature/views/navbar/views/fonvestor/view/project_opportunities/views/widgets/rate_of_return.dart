import 'package:common/common.dart';
import 'package:flutter/services.dart';
import 'package:misyonbank/feature/components/tool_tip_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/project_opportunities/project_opportunities_controller.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class RateOfReturn extends BaseGetView<ProjectOpportunitiesController> {
  const RateOfReturn({super.key});

  // Builds the main UI for the Rate of Return widget.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectOpportunitiesController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
        child: Column(
          children: [
            _buildTitle(),
            SizedBox(height: 30.h),
            _buildSingleSlider(),
            SizedBox(height: 20.h),
          ],
        ),
      );
    });
  }

  // Builds the title section including the title text and a tooltip.
  Widget _buildTitle() {
    return Row(
      children: [
        ScaleFactorAutoSizeText(
          text: LocalizationKeys.rateOfReturnKey.tr,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20.w),
        const ToolTipWidget(
          infoText: 'Rate of return Info',
          iconColor: AppColors.toolTipGreyColor,
        ),
      ],
    );
  }

  // Builds the slider section with minimum and maximum rate of return input fields.
  Widget _buildSingleSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 170.sp,
          child: generateTextField(
              label: "Minimum (%)",
              hintText: "30",
              maxLength: 3,
              textEditingController: TextEditingController(
                  text: controller.selectedRateOfEarnRange.value.start.toInt().toString()),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.selectedRateOfEarnRange.value = RangeValues(
                      double.parse(value), controller.selectedRateOfEarnRange.value.end);
                }
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ]),
        ),
        SizedBox(
          width: 170.sp,
          child: generateTextField(
            label: "Maksimum (%)",
            hintText: "100+",
            maxLength: 3,
            textEditingController: TextEditingController(
                text: controller.selectedRateOfEarnRange.value.end.toInt().toString()),
            onChanged: (value) {
              if (value.isNotEmpty) {
                controller.selectedRateOfEarnRange.value = RangeValues(
                    controller.selectedRateOfEarnRange.value.start, double.parse(value));
              }
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
          ),
        ),
      ],
    );
  }

  // A reusable function to generate custom text fields.
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
                labelColor: AppColors.primaryColor,
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

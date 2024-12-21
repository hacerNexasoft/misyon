import 'package:common/common.dart';
import 'package:flutter/services.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/transactions_view_controller.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class RateOfReturn extends BaseGetView<TransactionsViewController> {
  const RateOfReturn({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionsViewController>(builder: (_) {
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

  Widget _buildTitle() {
    return Row(
      children: [
        ScaleFactorAutoSizeText(
          text: LocalizationKeys.rateOfReturnKey.tr,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSingleSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 170.sp,
          child: generateTextField(
            label: "Minimum (%)",
            hintText: "60",
            maxLength: 300,
          ),
        ),
        SizedBox(
          width: 170.sp,
          child: generateTextField(
            label: "Maksimum (%)",
            hintText: "100+",
            maxLength: 300,
          ),
        ),
      ],
    );
  }

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
        padding:
            suffix != null ? EdgeInsets.only(right: 40.w) : EdgeInsets.zero,
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

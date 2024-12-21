import 'package:common/common.dart';
import 'package:flutter/services.dart';
import 'package:widgets/components.dart';

class CustomTextField extends BaseStatelessWidget {
  final bool isMoney;
  final bool isRate;
  final bool? isPrefixIcon;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? border;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final bool? filled;
  final Color? fillColor;
  final String? counterText;
  final bool? isDense;
  final TextStyle? hintStyle;
  final String? hintText;
  final String? label;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? contentVerticalPadding;
  final int? contentHorizontalPadding;
  final int? maxLines;
  final bool obscureText;
  final InputDecoration? decoration;
  final BoxConstraints? prefixIconConstraints;
  final bool enabled;
  final Widget? suffix;
  final Color? labelColor;
  final Function()? onTap;
  const CustomTextField({
    super.key,
    this.style,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.contentVerticalPadding,
    this.contentHorizontalPadding,
    this.textEditingController,
    this.maxLength,
    this.decoration,
    this.inputFormatters,
    this.border,
    this.maxLines = 1,
    this.disabledBorder,
    this.labelColor,
    this.errorBorder,
    this.enabledBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.filled,
    this.onChanged,
    this.fillColor,
    this.counterText,
    this.isDense,
    this.hintStyle,
    this.hintText,
    this.isMoney = false,
    this.isRate = false,
    this.isPrefixIcon,
    this.label,
    this.obscureText = false,
    this.enabled = true,
    this.suffix,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return label != null
        ? Container(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.03, vertical: Get.width * 0.03),
            decoration: BoxDecoration(
              color: fillColor ?? AppColors.textFieldFillColor,
              borderRadius: BorderRadius.circular(Get.width * .03),
            ),
            child: Column(
              crossAxisAlignment: label!.isEmpty
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                label!.isNotEmpty
                    ? ScaleFactorAutoSizeText(
                        text: label!,
                        style: theme.primaryTextTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: labelColor ?? AppColors.primaryGreyColor,
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.width * 0.001),
                  child: _textField,
                )
              ],
            ),
          )
        : _textField;
  }

  Widget get _textField => TextFormField(
        style: style ??
            theme.primaryTextTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
        validator: validator,
        keyboardType: keyboardType ??
            const TextInputType.numberWithOptions(decimal: true),
        controller: textEditingController,
        maxLength: maxLength,
        maxLines: maxLines,
        enabled: enabled,
        onTap: onTap,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        cursorColor: AppColors.primaryColor,
        decoration: decoration ??
            _inputDecoration(
              border: border,
              enabledBorder: enabledBorder,
              disabledBorder: disabledBorder,
              focusedBorder: focusedBorder,
              errorBorder: errorBorder,
              focusedErrorBorder: focusedErrorBorder,
              counterText: counterText,
              fillColor: fillColor,
              filled: filled,
              hintStyle: hintStyle,
              hintText: hintText,
              isDense: isDense,
            ),
      );

  InputDecoration _inputDecoration({
    InputBorder? border,
    InputBorder? disabledBorder,
    InputBorder? errorBorder,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    InputBorder? focusedErrorBorder,
    bool? filled,
    Color? fillColor,
    String? counterText,
    bool? isDense,
    TextStyle? hintStyle,
    String? hintText,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: (contentHorizontalPadding ?? 12).toDouble(),
        vertical: (contentVerticalPadding ?? 30).toDouble(),
      ),
      suffixIcon: suffixIcon,
      border: border,
      disabledBorder: disabledBorder,
      errorBorder: errorBorder,
      enabledBorder: enabledBorder,
      suffix: suffix,
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIconConstraints,
      focusedBorder: focusedBorder,
      focusedErrorBorder: focusedErrorBorder,
      filled: filled ?? true,
      fillColor: fillColor ?? AppColors.fillColor,
      counterText: counterText ?? '',
      isDense: isDense ?? true,
      hintStyle: hintStyle ??
          theme.primaryTextTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.hintColor,
          ),
      hintText: hintText ?? '',
      floatingLabelBehavior: FloatingLabelBehavior.always,
      errorStyle: theme.primaryTextTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.primaryRedColor,
      ),
    );
  }
}

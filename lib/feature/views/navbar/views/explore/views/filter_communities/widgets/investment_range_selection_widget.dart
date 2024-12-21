part of '../filter_communities_view.dart';

class _InvestmentRangeSelectionWidget
    extends BaseGetView<FilterCommunitiesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTitle(),
          SizedBox(height: 10.h),
          _buildSingleSlider(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        ScaleFactorAutoSizeText(
          text: LocalizationKeys.investmentRangeTextKey.tr,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10.w),
        const ToolTipWidget(
          infoText: 'Investment Range Info',
          iconColor: AppColors.toolTipGreyColor,
        ),
      ],
    );
  }

  Widget _buildSingleSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 160.sp,
          child: generateTextField(
            label: "Minimum (%)",
            hintText: "60",
            maxLength: 300,
          ),
        ),
        SizedBox(
          width: 160.sp,
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

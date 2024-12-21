part of '../../../../invest_view.dart';

class _OtherSelectionContent extends BaseGetView<InvestViewController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          generateTextField(
            label: 'IBAN',
            textEditingController: controller.ibanTextController,
          ),
          SizedBox(height: 20.h),
          generateTextField(
            label: LocalizationKeys.recipientFullNameTextKey.tr,
            textEditingController: controller.recipientFullNameController,
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ScaleFactorAutoSizeText(
              text: Formatter.formatName(
                  controller.selectedBankAccount.value?.accountHolder),
              style: theme.primaryTextTheme.bodySmall?.copyWith(
                color: AppColors.primaryGreyColor,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Obx(() => generateTextField(
                textEditingController: controller.transactionAmountController,
                inputFormatters: Formatter.moneyInputFormat(2),
                maxLength: 20,
                label: controller.transactionAmount.value == 0.0
                    ? ''
                    : LocalizationKeys.transactionAmountTextKey.tr,
                onChanged: controller.onTransactionAmountChanged,
                fillColor: controller.fillColor.value,
                borderColor: controller.borderColor.value,
                hintText: LocalizationKeys.transactionAmountTextKey.tr,
                suffix: _useAllSuffixWidget,
              )),
          SizedBox(height: 20.h),
          _WarningsWidget(),
          SizedBox(height: 20.h),
          generateTextField(
            enabled: false,
            label: LocalizationKeys.transactionDateTextKey.tr,
            textEditingController: controller.transactionDateController,
            onTap: () async => await controller.selectDate(context),
            suffix: SvgPicture.asset(
              AssetConstants.calendarIcon,
            ),
          ),
          SizedBox(height: 20.h),
          generateTextField(
              enabled: false,
              label: LocalizationKeys.paymentTypeTextKey.tr,
              textEditingController: controller.paymentTypeController,
              onTap: () async => await controller.selectPaymentType(context),
              suffix: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.primaryGreyColor,
              )),
          SizedBox(height: 20.h),
          generateTextField(
            textEditingController: controller.codeTextController,
            hintText: 'CANOPY12345678',
          ),
          SizedBox(height: 20.h),
        ],
      ),
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
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding:
              suffix != null ? EdgeInsets.only(right: 40.w) : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: fillColor ?? AppColors.textFieldFillColor,
            borderRadius: BorderRadius.circular(Get.width * .03),
            border: Border.all(
              color: borderColor ?? Colors.transparent,
            ),
          ),
          child: suffix != null
              ? Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        filled: true,
                        textEditingController: textEditingController,
                        hintText: hintText,
                        onTap: onTap,
                        hintStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
                          color: AppColors.primaryGreyColor,
                        ),
                        label: label,
                        contentVerticalPadding: 0,
                        contentHorizontalPadding: 0,
                        maxLength: maxLength,
                        inputFormatters: inputFormatters,
                        enabled: enabled,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Get.width * .03),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.transparent,
                        style: theme.primaryTextTheme.bodyMedium?.copyWith(
                          color: AppColors.black,
                        ),
                        onChanged: onChanged,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    suffix,
                  ],
                )
              : CustomTextField(
                  filled: true,
                  textEditingController: textEditingController,
                  hintText: hintText,
                  hintStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryGreyColor,
                  ),
                  label: label,
                  contentVerticalPadding: 0,
                  contentHorizontalPadding: 0,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Get.width * .03),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: AppColors.textFieldFillColor,
                  style: theme.primaryTextTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                  ),
                  onChanged: onChanged,
                  keyboardType: TextInputType.text,
                ),
        ),
      );

  Widget get _useAllSuffixWidget => Padding(
        padding: EdgeInsets.only(left: 40.w),
        child: GestureDetector(
          onTap: controller.useAllBalance,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(right: 40.w),
                  height: 30.h,
                  width: 3.w,
                  color: AppColors.checkboxBorderColor,
                ),
              ),
              ScaleFactorAutoSizeText(
                text: LocalizationKeys.useAllTextKey.tr,
                style: theme.primaryTextTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
}

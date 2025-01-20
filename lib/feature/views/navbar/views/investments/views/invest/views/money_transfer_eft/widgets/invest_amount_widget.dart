part of '../../../invest_view.dart';

class _InvestAmountWidget extends BaseGetView<InvestViewController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScaleFactorAutoSizeText(
                text: LocalizationKeys.numberOfInvestorsTextKey.tr,
                style: theme.primaryTextTheme.bodyMedium?.copyWith(
                  color: AppColors.darkGreyColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _amountBox,
            ],
          ),
          _divider,
        ],
      ),
    );
  }

  Widget get _amountBox => Obx(() => Flexible(
        child: Container(
          margin: EdgeInsets.only(left: 10.w),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          decoration: BoxDecoration(
            color: controller.fillColor.value,
            borderRadius: BorderRadius.circular(12.r),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: controller.borderColor.value,
            ),
          ),
          child: _amountInput,
        ),
      ));

  Widget get _amountInput => IntrinsicWidth(
        child: CustomTextField(
          hintText: '0',
          hintStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textEditingController: controller.amountTextController,
          filled: true,
          contentVerticalPadding: 10,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Get.width * .03),
            borderSide: BorderSide.none,
          ),
          maxLength: 10,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Get.width * .03),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.transparent,
          style: theme.primaryTextTheme.bodyMedium?.copyWith(
            color: controller.textColor.value,
            fontWeight: FontWeight.bold,
          ),
          inputFormatters: Formatter.moneyInputFormat(2),
          onChanged: controller.onInvestAmountChanged,
          keyboardType: TextInputType.number,
        ),
      );

  Widget get _divider => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: const Divider(
          color: AppColors.darkGreyColor,
          thickness: .2,
        ),
      );
}

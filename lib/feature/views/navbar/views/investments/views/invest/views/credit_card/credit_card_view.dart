part of '../../invest_view.dart';

class _CreditCardView extends BaseGetView<InvestViewController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.selectedBankAccount.value?.category ==
                BankAccountCategory.mission ||
            (controller.selectedBankAccount.value == null &&
                controller.selectedBank.value == null)
        ? _buildBody
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: _buildBody,
          ));
  }

  Widget get _buildBody => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [_CradiCardSelectedContent()],
          ),
          Column(
            children: [
              _ReadAndAcceptWidget(),
              const Divider(color: AppColors.darkGreyColor, thickness: .2),
              _investButton,
            ],
          ),
        ],
      );

  Widget get _investButton => Padding(
        padding: EdgeInsets.all(10.sp),
        child: Obx(() => CustomButton(
            onTap: () {
              Get.to(_CradiCardInvestmentConfirmationView(),
                  transition: Transition.downToUp);
            },
            borderRadius: 999.r,
            isEnable: controller.isButtonEnabled.value,
            child: ScaleFactorAutoSizeText(
              text: LocalizationKeys.investTextKey.tr,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: controller.isButtonEnabled.value
                    ? AppColors.white
                    : AppColors.primaryLightGreyColor,
                fontWeight: FontWeight.bold,
              ),
            ))),
      );
}

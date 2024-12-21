part of '../../invest_view.dart';

class _MoneyTransferEftView extends BaseGetView<InvestViewController> {
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
            children: [
              _SelectAccountWidget(),
              _getWidgetByType,
            ],
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
        padding: const EdgeInsets.all(10),
        child: Obx(() => CustomButton(
            onTap: () {
              Get.to(_MonyTransferEftInvestmentConfirmationView(),
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

  Widget get _getWidgetByType {
    if (controller.selectedBank.value != null) {
      return _OtherSelectionContent();
    }
    switch (controller.selectedBankAccount.value?.category) {
      case BankAccountCategory.mission:
        return _MissionSelectionContent();
      case BankAccountCategory.otherAccounts:
        return _OtherSelectionContent();
      default:
        return _MissionSelectionContent();
    }
  }
}

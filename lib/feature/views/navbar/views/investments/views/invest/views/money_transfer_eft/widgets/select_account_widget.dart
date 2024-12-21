part of '../../../invest_view.dart';

class _SelectAccountWidget extends BaseGetView<InvestViewController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => _BankAccountSelectionView(),
        binding: BankAccountSelectionViewBinding(),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        decoration: const BoxDecoration(
          color: AppColors.fillColor,
        ),
        child: _content,
      ),
    );
  }

  Widget get _content => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title,
          SizedBox(height: 10.h),
          Obx(() => (controller.selectedBankAccount.value != null ||
                  controller.selectedBank.value != null)
              ? _BankAccountHeaderWidget(
                  title: controller.selectedBankAccount.value?.title ??
                      controller.selectedBank.value?.name,
                  subtitle: controller.selectedBankAccount.value
                      ?.getHeaderTitle(true),
                  imageUrl: controller.selectedBankAccount.value?.imageUrl ??
                      controller.selectedBank.value?.imageUrl,
                )
              : _bottom),
        ],
      );

  Widget get _title => ScaleFactorText(
        text: LocalizationKeys.accountToWithdrawMoneyTextKey.tr,
        style: theme.primaryTextTheme.bodySmall?.copyWith(
          color: AppColors.darkGreyColor,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget get _bottom => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScaleFactorText(
            text: LocalizationKeys.selectAccountTextKey.tr,
            style: theme.primaryTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              AssetConstants.arrowForwardIOSIcon,
              height: 12.w,
            ),
          ),
        ],
      );
}

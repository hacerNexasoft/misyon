part of '../../../../../invest_view.dart';

class _BankAccountListItemWidget extends BaseStatelessWidget {
  final BankAccountModel? bankAccount;
  final VoidCallback? onTap;
  const _BankAccountListItemWidget({
    required this.bankAccount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        color: Colors.transparent,
        child: Column(
          children: [
            _BankAccountHeaderWidget(
              title: bankAccount?.title,
              subtitle: bankAccount?.getHeaderTitle(false),
              imageUrl: bankAccount?.imageUrl,
            ),
            SizedBox(height: 20.h),
            _balanceInformations,
          ],
        ),
      ),
    );
  }

  Widget get _balanceInformations => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _balanceInfoItem(
            title: LocalizationKeys.balanceTextKey.tr,
            value: bankAccount?.balance.toString() ?? '',
          ),
          _balanceInfoItem(
            title: LocalizationKeys.availableBalanceTextKey.tr,
            value: bankAccount?.availableBalance.toString() ?? '',
          ),
        ],
      );

  Widget _balanceInfoItem({
    required String title,
    required String value,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            ScaleFactorAutoSizeText(
              text: title,
              style: theme.primaryTextTheme.bodyMedium
                  ?.copyWith(color: AppColors.darkGreyColor),
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: ScaleFactorAutoSizeText(
                text: Formatter.formatMoney(value),
                style: theme.primaryTextTheme.bodyMedium,
              ),
            ),
          ],
        ),
      );
}

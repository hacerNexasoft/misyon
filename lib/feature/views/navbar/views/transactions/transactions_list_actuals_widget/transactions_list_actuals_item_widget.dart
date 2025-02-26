part of '../transactions_view.dart';

class _TransactionsListItemWidget extends BaseGetView<TransactionsViewController> {
  final InvestmentModel investment;
  const _TransactionsListItemWidget({required this.investment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(Get.width * 0.03),
      ),
      child: _content,
    );
  }

  Widget get _content => Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                ProjectCustomCachedNetworkImageComp(
                  imageUrl: investment.projectLogoUrl,
                  size: 40.w,
                ),
                SizedBox(width: 20.w),
                _buildInfoColumn(),
              ],
            ),
          ),
          _buildMoneyColumn(),
          SizedBox(
            width: 10.w,
          ),
          _buildPaymentMethodIcon(),
        ],
      );

  Expanded _buildInfoColumn() {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScaleFactorAutoSizeText(
            text: investment.seoName,
            style: theme.primaryTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          ScaleFactorAutoSizeText(
            maxLines: 1,
            text: "Yatırım(${investment.investmentType.toStringValue})",
            overflow: TextOverflow.ellipsis,
            style: theme.primaryTextTheme.bodyMedium!.copyWith(color: AppColors.darkGreyColor),
          )
        ],
      ),
    );
  }

  Expanded _buildMoneyColumn() {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ScaleFactorAutoSizeText(
            text: Formatter.formatMoney(investment.committedInvestment),
            maxLines: 1,
            style: theme.primaryTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          if (investment.isRefundable)
            GestureDetector(
              onTap: () => controller.showBottomSheet(),
              child: ScaleFactorAutoSizeText(
                text: "İptal Et",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.primaryTextTheme.bodySmall!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodIcon() {
    return Expanded(child: iconSelector(value: investment.committedInvestment)
        /*const Icon(
              Icons.help_outline,
              color: AppColors.black,
            ),*/
        );
  }

  Widget iconSelector({required double value}) {
    if (value > 0) {
      return SvgPicture.asset(AssetConstants.arrowDownLeftIcon);
    } else {
      return SvgPicture.asset(AssetConstants.arrowUpRightIcon);
    }
  }
}

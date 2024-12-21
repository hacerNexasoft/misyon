part of '../transactions_view.dart';

class _TransactionsListItemWidget
    extends BaseGetView<TransactionsViewController> {
  final ProjectModel? projectModel;
  const _TransactionsListItemWidget({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return projectModel != null
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 5.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(Get.width * 0.03),
            ),
            child: _content,
          )
        : const SizedBox();
  }

  Widget get _content => Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                ProjectCustomCachedNetworkImageComp(
                  imageUrl: projectModel?.imageUrl,
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
            text: projectModel?.ownerName ?? '',
            style: theme.primaryTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          ScaleFactorAutoSizeText(
            maxLines: 1,
            text: "${projectModel?.monthlyPaymentCount}",
            overflow: TextOverflow.ellipsis,
            style: theme.primaryTextTheme.bodyMedium!
                .copyWith(color: AppColors.darkGreyColor),
          )
        ],
      ),
    );
  }

  Expanded _buildMoneyColumn() {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: projectModel?.accountPaymentMethod != null
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ScaleFactorAutoSizeText(
            text: Formatter.formatMoney(projectModel?.amountReceived),
            maxLines: 1,
            style: theme.primaryTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          if (projectModel?.accountPaymentMethod != null)
            GestureDetector(
              onTap: () => controller.showBottomSheet(),
              child: ScaleFactorAutoSizeText(
                text: projectModel?.accountPaymentMethod,
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
    return Expanded(
      child: projectModel?.paymentMethod != null
          ? projectModel!.paymentMethod!.icon
          : const Icon(
              Icons.help_outline,
              color: AppColors.black,
            ),
    );
  }
}

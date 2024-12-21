part of '../../investments_view.dart';

class _InvestmentsListItemWidget
    extends BaseGetView<InvestmentsViewController> {
  final InvestmentsItemModel? investmentsItemModel;
  const _InvestmentsListItemWidget({required this.investmentsItemModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.selectInvestment(investmentsItemModel!);
        Get.dropdownBottomSheet(child: _InvestmentDetailBottomSheet());
      },
      child: investmentsItemModel != null
          ? Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: _content,
            )
          : const SizedBox(),
    );
  }

  Widget get _content => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProjectCustomCachedNetworkImageComp(
            imageUrl: investmentsItemModel?.imageUrl,
            size: 32.sp,
          ),
          SizedBox(
            width: 8.sp,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _contentHeader,
                SizedBox(height: 4.h),
                _contentBottom,
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 15.sp,
              color: AppColors.grey200Color,
            ),
          ),
        ],
      );

  Widget get _contentHeader => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ScaleFactorAutoSizeText(
                text: investmentsItemModel?.companyName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.primaryTextTheme.bodyLarge?.copyWith(
                    color: AppColors.warmGrayColor,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 20.w),
          Flexible(
            child: ScaleFactorAutoSizeText(
              text: Formatter.formatMoney(
                  investmentsItemModel?.totalInvestmentAmount),
              maxLines: 1,
              style: theme.primaryTextTheme.bodyLarge
                  ?.copyWith(color: AppColors.warmGrayColor),
            ),
          ),
        ],
      );

  Widget get _contentBottom {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ScaleFactorAutoSizeText(
          text: investmentsItemModel?.statusName ==
                  MyInvestmentsProcess.returnPeriod.investmentProcessString
              ? investmentsItemModel?.rateOfReturnDescription
              : investmentsItemModel?.statusName,
          style: theme.primaryTextTheme.bodyMedium?.copyWith(
              color: investmentsItemModel?.statusName ==
                      MyInvestmentsProcess.returnPeriod.investmentProcessString
                  ? AppColors.primaryColor
                  : AppColors.darkGreyColor,
              fontWeight: FontWeight.bold),
        ),
        if (investmentsItemModel?.statusName !=
            MyInvestmentsProcess.returnPeriod.investmentProcessString)
          GestureDetector(
            onTap: () {
              controller.isTapped.value = !controller.isTapped.value;
            },
            child: Opacity(
              opacity: 1.0,
              child: ScaleFactorAutoSizeText(
                text: "18 Gün",
                style: theme.primaryTextTheme.bodyMedium!.copyWith(
                    color: AppColors.darkTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        else
          ScaleFactorAutoSizeText(
            text:
                "+${Formatter.formatMoney(investmentsItemModel?.labelAmount)}",
            style: theme.primaryTextTheme.bodySmall!.copyWith(
              color: AppColors.primaryGreenColor,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}

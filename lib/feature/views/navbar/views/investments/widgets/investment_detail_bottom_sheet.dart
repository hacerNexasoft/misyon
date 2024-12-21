part of '../investments_view.dart';

class _InvestmentDetailBottomSheet
    extends BaseGetView<InvestmentsViewController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomSheetSafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 10.sp),
          width: Get.width,
          height: Get.height * 0.9,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTitle(),
                _buildSelectedElement,
                _buildBody(),
                _buildYieldTable,
                _buildReturnTable,
                _buildReturnTableList,
                _buildButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildSelectedElement => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleFactorAutoSizeText(
              text: "KAMPANYA ADI",
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.darkGreyColor),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Row(
              children: [
                ProjectCustomCachedNetworkImageComp(
                  imageUrl: controller.selectedInvestment.value?.imageUrl,
                  size: 32.sp,
                ),
                SizedBox(
                  width: 8.sp,
                ),
                ScaleFactorAutoSizeText(
                  text: controller.selectedInvestment.value?.companyName,
                  style: theme.primaryTextTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkTextColor),
                ),
              ],
            )
          ],
        ),
      );

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      width: Get.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ScaleFactorAutoSizeText(
            text: LocalizationKeys.investmentItemDetailTextKey.tr,
            style: theme.primaryTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Positioned(
            right: 0,
            child: InkWell(
              child: const Icon(
                Icons.close,
                color: AppColors.darkTextColor,
              ),
              onTap: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildButton => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: CustomButton(
          borderRadius: 999.r,
          onTap: () => Get.toNamed(
            AppRoutes.detailView,
            arguments: {
              'projectName': controller.selectedInvestment.value?.companyName,
            },
          ),
          child: ScaleFactorAutoSizeText(
            text: "Kampanya Detayına Git",
            style: theme.primaryTextTheme.bodyLarge!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  Widget _buildBody() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.investmentBottomSheetDetailItemList.length,
          itemBuilder: (context, index) {
            final detailTitle =
                controller.investmentBottomSheetDetailItemList[index];
            final detailValue = controller.getInvestmentDetail(
                controller.selectedInvestment.value!, detailTitle);
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ScaleFactorAutoSizeText(
                      text: detailTitle,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.darkGreyColor,
                      ),
                    ),
                  ),
                  ScaleFactorAutoSizeText(
                    text: detailValue.key,
                    style: theme.primaryTextTheme.bodyLarge?.copyWith(
                      color: detailValue.value,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
  Widget get _buildYieldTable => Column(
        children: [
          Divider(
            color: AppColors.secondaryGreyColor,
            height: 0.5.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildYieldColumn(LocalizationKeys.earningFrequencyTextKey.tr,
                    "${controller.selectedInvestment.value!.timeRemainingUntilReturn} Ay"),
                buildYieldColumn(
                    LocalizationKeys.earningRateKey.tr,
                    Formatter.formatPercent(
                        controller.selectedInvestment.value!.rateOfReturn)),
                buildYieldColumn(LocalizationKeys.frequencyOfReturnTextKey.tr,
                    controller.selectedInvestment.value!.frequencyOfReturn),
              ],
            ),
          ),
          Divider(
            color: AppColors.secondaryGreyColor,
            height: 0.5.sp,
          ),
        ],
      );
  Widget buildYieldColumn(detailTitle, detailValue) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleFactorAutoSizeText(
            text: detailTitle,
            style: theme.primaryTextTheme.bodyMedium?.copyWith(
              color: AppColors.darkGreyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          ScaleFactorAutoSizeText(
            text: detailValue.toString(),
            style: theme.primaryTextTheme.bodyLarge?.copyWith(
              color: AppColors.darkTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
  Widget get _buildReturnTable => Padding(
        padding: EdgeInsets.only(
            left: 20.sp, top: 10.sp, bottom: 10.sp, right: 10.sp),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScaleFactorAutoSizeText(
                  text: "ANA PARA",
                  style: theme.primaryTextTheme.bodyMedium?.copyWith(
                    color: AppColors.darkGreyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ScaleFactorAutoSizeText(
                  text: "GETİRİ TUTARU",
                  style: theme.primaryTextTheme.bodyMedium?.copyWith(
                    color: AppColors.darkGreyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ScaleFactorAutoSizeText(
                  text: "VADE TARİHİ",
                  style: theme.primaryTextTheme.bodyMedium?.copyWith(
                    color: AppColors.darkGreyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      );

  Widget buildCustomRow(int index, double value1, double value2, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ScaleFactorAutoSizeText(
                text: index.toString(),
                style: theme.primaryTextTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10.sp,
              ),
              ScaleFactorAutoSizeText(
                text: Formatter.formatMoney(value1),
                style: theme.primaryTextTheme.bodyMedium?.copyWith(
                  color: AppColors.darkTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ScaleFactorAutoSizeText(
            text: Formatter.formatMoney(value2),
            style: theme.primaryTextTheme.bodyMedium?.copyWith(
              color: AppColors.darkTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          ScaleFactorAutoSizeText(
            text: text,
            style: theme.primaryTextTheme.bodyMedium?.copyWith(
              color: AppColors.darkTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildReturnTableList {
    int itemCount =
        controller.selectedInvestment.value?.timeRemainingUntilReturn ?? 0;

    return SizedBox(
      height: Get.height * 0.25,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(itemCount, (index) {
            double value1 =
                (controller.selectedInvestment.value?.totalInvestmentAmount ??
                        0) /
                    (controller.selectedInvestment.value
                            ?.timeRemainingUntilReturn ??
                        1);
            double value2 =
                controller.selectedInvestment.value?.currentEarnings ?? 0;
            String text = controller.selectedInvestment.value?.maturityDate
                    ?.toLocal()
                    .toString()
                    .split(' ')[0] ??
                "";

            return buildCustomRow(index + 1, value1, value2, text);
          }),
        ),
      ),
    );
  }
}

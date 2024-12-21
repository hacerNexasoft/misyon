part of '../../invest_view.dart';

class _CradiCardInvestmentConfirmationView
    extends BaseGetView<InvestViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: const IconThemeData(color: AppColors.black),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildSelectedInstrument,
                  SizedBox(height: 12.sp),
                  buildInvestmentDemand("YATIRIM TALEBİ"),
                  buildAdditionalRow("Platform", "Fonvestor"),
                  buildAdditionalRow(
                      "Vade", "${controller.selectedProject!.maturity} Ay"),
                  buildAdditionalRow("Periyot",
                      controller.selectedProject!.earningFrequency.toString()),
                  buildAdditionalRow(
                      "Getiri Oranı",
                      Formatter.formatPercent(
                          controller.selectedProject!.earningRate.toString())),
                  buildRisk,
                  SizedBox(height: 12.sp),
                  buildInvestmentDemand("HESAP BİLGİLERİ"),
                  buildAdditionalRow(
                    "Ödeme Tipi",
                    "Kredi Kart",
                  ),
                  buildAdditionalRow(
                    "Alınacak Tutar",
                    Formatter.formatMoney(controller.investAmount.value),
                  ),
                  buildAdditionalRow(
                    "Dönem Sonu Getirisi",
                    Formatter.formatMoney(controller.investAmount.value *
                        (1 +
                            controller.selectedProject!.earningRate!.toInt() /
                                100)),
                  ),
                  buildAdditionalRow("İşlem Ücret", "0,00 ₺"),
                ],
              ),
            ),
          ),
          _buildConfirmationButton,
        ],
      ),
    );
  }

  Widget get _buildConfirmationButton => SizedBox(
        width: Get.width,
        child: Column(
          children: [
            Divider(
              color: AppColors.darkTextColor.withAlpha(20),
              height: 0.5.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.darkGreyColor,
                    size: 20.sp,
                  ),
                  SizedBox(
                    width: 5.sp,
                  ),
                  ScaleFactorAutoSizeText(
                    text: "Yatırımın getirisi vadesiz hesabınıza yatacaktır.",
                    textAlign: TextAlign.start,
                    style: theme.primaryTextTheme.bodySmall?.copyWith(
                      color: AppColors.darkGreyColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.sp, right: 20.sp, bottom: 20.sp, top: 5.sp),
              child: CustomButton(
                onTap: () {},
                borderRadius: 999.r,
                child: ScaleFactorAutoSizeText(
                  text: "Onayla",
                  textAlign: TextAlign.start,
                  style: theme.primaryTextTheme.bodyLarge?.copyWith(
                    color: AppColors.backgroundColor,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget get buildSelectedInstrument => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleFactorAutoSizeText(
              text: "İŞLEM ONAYI",
              textAlign: TextAlign.start,
              style: theme.primaryTextTheme.bodySmall?.copyWith(
                color: AppColors.darkGreyColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 12.sp,
            ),
            Row(
              children: [
                ProjectCustomCachedNetworkImageComp(
                  imageUrl: controller.selectedProject!.imageUrl.toString(),
                  isCircular: true,
                  size: 32.sp,
                ),
                SizedBox(
                  width: 12.sp,
                ),
                ScaleFactorAutoSizeText(
                  text: controller.selectedProject?.ownerName.toString(),
                  textAlign: TextAlign.start,
                  style: theme.primaryTextTheme.bodyLarge?.copyWith(
                    color: AppColors.darkTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      );
  Widget buildInvestmentDemand(String title) => Column(
        children: [
          Divider(
            color: AppColors.darkTextColor.withAlpha(20),
            height: 0.5.sp,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            width: Get.width,
            color: AppColors.textFieldFillColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: ScaleFactorAutoSizeText(
                text: title,
                textAlign: TextAlign.start,
                style: theme.primaryTextTheme.bodySmall?.copyWith(
                  color: AppColors.darkGreyColor.withAlpha(100),
                ),
              ),
            ),
          )
        ],
      );
  Widget buildAdditionalRow(String title, String value) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScaleFactorAutoSizeText(
              text: title,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.darkTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 200.sp,
              child: ScaleFactorAutoSizeText(
                text: value,
                maxLines: 2,
                textAlign: TextAlign.end,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.darkTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );

  Widget get buildRisk => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ScaleFactorAutoSizeText(
                  text: "Risk",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.darkTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 12.sp,
                ),
                const ToolTipWidget(
                  infoText: "Riski beleirtir",
                  iconColor: AppColors.hintColor,
                )
              ],
            ),
            SizedBox(
              height: 12.sp,
            ),
            Container(
              width: 30.sp,
              height: 14.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: controller.selectedProject?.riskType!.color),
            )
          ],
        ),
      );
}

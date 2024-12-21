import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/views/yield_calculation/opportunities/opportunities_view.dart';
import 'package:misyonbank/feature/views/yield_calculation/yield_calculation_view_controller.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:widgets/components.dart';

class YieldCalculationResultView
    extends BaseGetView<YieldCalculationViewController> {
  const YieldCalculationResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        child: CustomButton(
          borderRadius: 30.r,
          onTap: () {
            Get.to(const OpportunitiesView());
            controller.filterEarningRates();
          },
          child: ScaleFactorAutoSizeText(
            text: LocalizationKeys.calculateYieldTextKey.tr,
            style: theme.primaryTextTheme.bodyLarge?.semibold.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: const IconThemeData(color: AppColors.black),
      title: ScaleFactorAutoSizeText(
        text: LocalizationKeys.yieldCalculationTitleTextKey.tr,
        style: theme.primaryTextTheme.bodyLarge?.semibold,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildItem(
            title: LocalizationKeys.investAmountTextKey.tr,
            value: Formatter.formatMoney(controller.investAmount.value),
          ),
          const Divider(
            color: AppColors.textFieldFillColor,
          ),
          _buildItem(
            title: LocalizationKeys.maturityTextKey.tr,
            value:
                '${controller.selectedMaturity.value} ${LocalizationKeys.monthTextKey.tr}',
          ),
          const Divider(
            color: AppColors.textFieldFillColor,
          ),
          _buildItem(
            title: LocalizationKeys.annualReturnRateTextKey.tr,
            value: '%${controller.rateController.text}',
          ),
          SizedBox(
            height: 20.sp,
          ),
          _buildCalculationResult(),
        ],
      ),
    );
  }

  Widget _buildCalculationResult() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: ScaleFactorAutoSizeText(
                text: "HESAPLAMA SONUCU",
                style: theme.primaryTextTheme.bodySmall?.copyWith(
                    color: AppColors.toolTipGreyColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const Divider(
            color: AppColors.textFieldFillColor,
          ),
        ],
      );

  Widget _buildItem({required String title, required String value}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScaleFactorAutoSizeText(
              text: title,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: AppColors.darkGreyColor,
              ),
            ),
            ScaleFactorAutoSizeText(
              text: value,
              style: theme.primaryTextTheme.bodyMedium?.semibold,
            ),
          ],
        ),
      );
}

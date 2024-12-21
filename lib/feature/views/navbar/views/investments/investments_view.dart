import 'package:common/common.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misyonbank/feature/components/tool_tip_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/investments/investments_view_controller.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/widget_models/investments_item_model.dart';
import 'package:misyonbank/product/utils/extensions.dart';
import 'package:misyonbank/product/utils/formatter.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'widgets/investments_list_widgets/investments_list_widget.dart';
part 'widgets/investments_list_widgets/investments_list_item_widget.dart';
part 'widgets/investments_list_widgets/my_investments_header_widget.dart';
part 'widgets/filter_bottom_sheet/filter_bottom_sheet_widget.dart';
part 'widgets/filter_bottom_sheet/bottom_sheet_header_widget.dart';
part 'widgets/filter_bottom_sheet/bottom_sheet_options_widget.dart';
part 'widgets/filter_bottom_sheet/bottom_sheet_apply_button_widget.dart';
part 'widgets/investments_list_widgets/empty_investment_widget.dart';
part 'widgets/investment_detail_bottom_sheet.dart';

class InvestmentsView extends BaseGetView<InvestmentsViewController> {
  const InvestmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleText,
            if (controller.isExpanded.value) _buildFinancialAssetDetail,
            const _MyInvestmentsHeaderWidget(),
            _InvestmentsListWidget(),
            _buildExplanation
          ],
        ),
      ),
      onLoading: const LoadingWidget(),
      onEmpty: _EmptyInvestmentWidget(
        icon: AssetConstants.emptyItemIcon,
        text: LocalizationKeys.emptySearchTextKey.tr,
      ),
      onError: (error) => ScaleFactorAutoSizeText(text: error.toString()),
    );
  }

  Widget get _buildExplanation => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
        child: Column(
          children: [
            Divider(
              color: AppColors.secondaryGreyColor,
              height: 0.5.sp,
            ),
            SizedBox(
              height: 10.sp,
            ),
            ScaleFactorAutoSizeText(
              text: controller.explanationText,
              style: theme.primaryTextTheme.bodyMedium!
                  .copyWith(color: AppColors.darkGreyColor),
            ),
          ],
        ),
      );

  Widget get _buildTitleText => InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          controller.isExpanded.value = !controller.isExpanded.value;
          controller.update();
        },
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ScaleFactorAutoSizeText(
                    text: "Varlık Detayı",
                    style: theme.primaryTextTheme.bodyLarge!.copyWith(
                        color: AppColors.darkTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.sp),
                  const ToolTipWidget(
                    infoText: "Varlık Detayı",
                    iconColor: AppColors.toolTipGreyColor,
                  ),
                ],
              ),
              Icon(
                controller.isExpanded.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down_sharp,
                size: 25.sp,
                color: AppColors.grey200Color,
              ),
            ],
          ),
        ),
      );

  Widget get _buildFinancialAssetDetail => Column(
        children: [
          Divider(
            color: AppColors.secondaryGreyColor,
            height: 0.5.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 16.sp,
                          height: 16.sp,
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreenColor,
                            borderRadius: BorderRadius.circular(Get.width),
                          ),
                        ),
                        SizedBox(width: 10.sp),
                        ScaleFactorAutoSizeText(
                          text: "Ödenen Getiri Tutarı",
                          style: theme.primaryTextTheme.bodyMedium!.copyWith(
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ScaleFactorAutoSizeText(
                      text: Formatter.formatMoney(controller.yieldAmountPaid),
                      style: theme.primaryTextTheme.bodyLarge!.copyWith(
                        color: AppColors.darkTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 16.sp,
                          height: 16.sp,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(Get.width),
                          ),
                        ),
                        SizedBox(width: 10.sp),
                        ScaleFactorAutoSizeText(
                          text: "Beklenen Getiri Tutarı",
                          style: theme.primaryTextTheme.bodyMedium!.copyWith(
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ScaleFactorAutoSizeText(
                      text: Formatter.formatMoney(
                          controller.expectedReturnAmount),
                      style: theme.primaryTextTheme.bodyLarge!.copyWith(
                        color: AppColors.darkTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}

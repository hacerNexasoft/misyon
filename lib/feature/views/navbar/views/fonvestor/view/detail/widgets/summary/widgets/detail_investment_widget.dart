part of '../summary_view.dart';

class DetailInvestmentWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  DetailInvestmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildInvestmentInfo, SizedBox(height: 10.h), _buildDataCard],
    );
  }

  Widget get _buildInvestmentInfo => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ScaleFactorAutoSizeText(
                          text: LocalizationKeys.fundRaisedTextKey.tr,
                          style: theme.primaryTextTheme.bodyMedium?.copyWith(
                            color: AppColors.hintColor,
                          ),
                        ),
                        ScaleFactorAutoSizeText(
                          text: LocalizationKeys.targetFundTextKey.tr,
                          style: theme.primaryTextTheme.bodyMedium?.copyWith(
                            color: AppColors.hintColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ScaleFactorAutoSizeText(
                          text: '${controller.fundRaisedText} TL',
                          style: theme.primaryTextTheme.bodyLarge?.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        ScaleFactorAutoSizeText(
                          text: '${controller.targetFundText} TL',
                          style: theme.primaryTextTheme.bodyLarge?.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    ClipRRect(
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(999.r),
                        value: controller.getProgress(),
                        backgroundColor: AppColors.hintColor,
                        color: theme.primaryColor,
                        minHeight: 20.h,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      );
  Widget get _buildDataCard => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            child: Row(
              children: [
                Expanded(
                  child: MiniCardWidget(
                    showBorder: true,
                    title: LocalizationKeys.remainingDayTextKey.tr,
                    data:
                        controller.projectDetailModel.value?.remainingDay ?? '',
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: MiniCardWidget(
                    showBorder: false,
                    title: LocalizationKeys.investAmountTextKey.tr,
                    data: controller.projectDetailModel.value?.investment ?? '',
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: MiniCardWidget(
                    showBorder: false,
                    title: LocalizationKeys.completedTextKey.tr,
                    data: controller.projectDetailModel.value?.completed ?? '',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: MiniCardWidget(
                    showBorder: false,
                    title: LocalizationKeys.maturityTextKey.tr,
                    data: controller.projectDetailModel.value?.maturity ?? '',
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: MiniCardWidget(
                    showBorder: false,
                    title: LocalizationKeys.earningRateTextKey.tr,
                    data:
                        controller.projectDetailModel.value?.rateofReturn ?? '',
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: MiniCardWidget(
                    showBorder: false,
                    title: LocalizationKeys.earningFrequencyTextKey.tr,
                    data:
                        controller.projectDetailModel.value?.returnFrequency ??
                            '',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

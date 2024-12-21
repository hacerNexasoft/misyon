part of '../filter_communities_view.dart';

class _InvestmentTypeSelectionWidget
    extends BaseGetView<FilterCommunitiesController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterCommunitiesController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 10.h),
            _buildInvestmentTypeSelection(),
          ],
        ),
      );
    });
  }

  Widget _buildTitle() {
    return Row(
      children: [
        ScaleFactorAutoSizeText(
          text: LocalizationKeys.investmentTypeTextKey.tr,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20.w),
        const ToolTipWidget(
          infoText: 'Investment Type Info',
          iconColor: AppColors.toolTipGreyColor,
        ),
      ],
    );
  }

  Widget _buildInvestmentTypeSelection() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.investmentTypes.length,
          itemBuilder: (context, index) => CheckListItemComp(
            model: controller.investmentTypes[index],
            onChanged: (_) => controller.onInvestmentTypeSelected(index),
          ),
        ));
  }
}

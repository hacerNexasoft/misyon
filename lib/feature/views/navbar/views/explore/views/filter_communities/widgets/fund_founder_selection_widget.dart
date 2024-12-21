part of '../filter_communities_view.dart';

class _FundFounderSelectionWidget
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
            SizedBox(height: 20.h),
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
          text: LocalizationKeys.fundFounderTextKey.tr,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20.w),
        const ToolTipWidget(
          infoText: 'Fund Founder Info',
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
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.fundFounders.length,
              itemBuilder: (context, index) => CheckListItemComp(
                model: controller.fundFounders[index],
                onChanged: (_) => controller.onFundFounderSelected(index),
                imageUrl: controller.fundFounders[index].imageUrl,
              ),
            ),
            _buildAllButton(),
          ],
        ));
  }

  Widget _buildAllButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Align(
        alignment: Alignment.centerRight,
        child: ScaleFactorAutoSizeText(
          text: LocalizationKeys.seeAllFundFoundersTextKey.tr,
          style: theme.primaryTextTheme.bodySmall
              ?.copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

part of '../details_tab_view.dart';

class CompanyDetailWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  CompanyDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle,
        SizedBox(
          height: 10.h,
        ),
        _buildsubTitle,
        SizedBox(
          height: 10.h,
        ),
        _buildCompanyDetails
      ],
    );
  }

  Widget get _buildTitle => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: ScaleFactorAutoSizeText(
          text: LocalizationKeys.companyDetailTextKey.tr,
          style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
            color: AppColors.black,
          ),
        ),
      );
  Widget get _buildsubTitle => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ScaleFactorAutoSizeText(
              text: LocalizationKeys.detailcompanyTitleTextKet.tr,
              style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                color: AppColors.toolTipGreyColor,
              ),
            ),
          ),
          Container(
            width: Get.width,
            height: 1.h,
            color: AppColors.fillColor,
          )
        ],
      );
  Widget get _buildCompanyDetails => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            CustomCompanyDetailWidget(
              title: LocalizationKeys.companyNameTextKey.tr,
              explanation:
                  controller.projectDetailModel.value?.companyName ?? '',
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomCompanyDetailWidget(
              title: LocalizationKeys.foundationYearTextKey.tr,
              explanation:
                  controller.projectDetailModel.value?.foundationYear ?? '',
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomCompanyDetailWidget(
              title: LocalizationKeys.chairmanTextKey.tr,
              explanation: controller.projectDetailModel.value?.chairman ?? '',
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomCompanyDetailWidget(
              title: LocalizationKeys.numberofEmployeesTextKey.tr,
              explanation:
                  controller.projectDetailModel.value?.numberofEmployees ?? '',
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomCompanyDetailWidget(
              title: LocalizationKeys.companyAddressTextKey.tr,
              explanation:
                  controller.projectDetailModel.value?.companyAddress ?? '',
            ),
          ],
        ),
      );
}

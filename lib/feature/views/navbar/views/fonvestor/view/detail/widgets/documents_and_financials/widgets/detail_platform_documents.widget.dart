part of '../documents_and_financials.dart';

class DetailPlatformDocumentsWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  DetailPlatformDocumentsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle,
          SizedBox(
            height: 10.h,
          ),
          _buildP,
          _buildplatformDocuments,
          _buildK,
          campaignDocuments
        ],
      ),
    );
  }

  Widget get _buildplatformDocuments => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
        child: Wrap(
          spacing: 10.w, // Yatay boşluk
          runSpacing: 10.w, // Dikey boşluk
          children: controller.projectDetailModel.value?.platformDocuments
                  ?.map((document) => CustomDocumentsButton(
                        title: document,
                      ))
                  .toList() ??
              [],
        ),
      );

  Widget get campaignDocuments => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
        child: Wrap(
          spacing: 10.w, // Yatay boşluk
          runSpacing: 10.w,
          children: controller.projectDetailModel.value?.campaignDocuments
                  ?.map((document) => Padding(
                        padding: EdgeInsets.only(bottom: 20.w),
                        child: CustomDocumentsButton(
                          title: document,
                        ),
                      ))
                  .toList() ??
              [],
        ),
      );
  Widget get _buildTitle => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ScaleFactorAutoSizeText(
              text: LocalizationKeys.detailplatformTitleTextKey.tr,
              style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
        ],
      );
  Widget get _buildP => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ScaleFactorAutoSizeText(
              text: LocalizationKeys.detailpDocumentsTextKey.tr,
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
  Widget get _buildK => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ScaleFactorAutoSizeText(
              text: LocalizationKeys.detailcDocumentsTextKey.tr,
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
}

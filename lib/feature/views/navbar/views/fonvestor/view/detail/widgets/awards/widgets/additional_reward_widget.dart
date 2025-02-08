part of '../awards_view.dart';

class AdditionalRewardWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  AdditionalRewardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProblem,
        ],
      ),
    );
  }

  Widget get _buildProblem => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
              ScaleFactorAutoSizeText(
                textAlign: TextAlign.start,
                text: LocalizationKeys.additionalRewardTextKey.tr,
                style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                width: Get.width,
                height: 82.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Get.height * 0.01),
                  image: const DecorationImage(
                    image: AssetImage(AssetConstants.additional),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ] +
            List.generate(
              controller.selectedProjectTrophiesList?.length ?? 0,
              (index) => Column(
                children: [
                  ScaleFactorAutoSizeText(
                    textAlign: TextAlign.start,
                    text: controller.selectedProjectTrophiesList![index].title,
                    style: theme.primaryTextTheme.bodySmall?.copyWith(
                      color: AppColors.darkGreyColor,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ScaleFactorAutoSizeText(
                    textAlign: TextAlign.start,
                    text: controller.selectedProjectTrophiesList![index].description,
                    style: theme.primaryTextTheme.bodySmall?.copyWith(
                      color: AppColors.darkGreyColor,
                    ),
                  ),
                ],
              ),
            ),
      );
}

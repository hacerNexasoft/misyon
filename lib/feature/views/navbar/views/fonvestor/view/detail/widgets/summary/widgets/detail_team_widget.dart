part of '../summary_view.dart';

class DetailTeamWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  DetailTeamWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildTitle, SizedBox(height: 20.h), _buildCard],
    );
  }

  Widget get _buildTitle => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScaleFactorAutoSizeText(
                  text: LocalizationKeys.detailTeamTextKey.tr,
                  style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                    color: AppColors.toolTipGreyColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.teamsView);
                  },
                  child: ScaleFactorAutoSizeText(
                    text: LocalizationKeys.allTextKey.tr,
                    style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            height: 1.h,
            color: AppColors.fillColor,
          )
        ],
      );
  Widget get _buildCard => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                controller.projectDetailModel.value?.teamImageUrl?.length ?? 0,
                (index) {
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: CustomTeamImageCard(
                  onTap: () {
                    Get.dropdownBottomSheet(
                      child: TeamsDetailsWidget(
                        color: ColorProvider.getColor(index),
                        imageUrl: controller.projectDetailModel.value
                                ?.teamImageUrl?[index] ??
                            '',
                        name: controller
                                .projectDetailModel.value?.teamName?[index] ??
                            '',
                        role: controller
                                .projectDetailModel.value?.teamrole?[index] ??
                            '',
                      ),
                    );
                  },
                  color: ColorProvider.getColor(index),
                  imageUrl: controller
                          .projectDetailModel.value?.teamImageUrl?[index] ??
                      '',
                  name: controller.projectDetailModel.value?.teamName?[index] ??
                      '',
                  role: controller.projectDetailModel.value?.teamrole?[index] ??
                      '',
                ),
              );
            }),
          ),
        ),
      );
}

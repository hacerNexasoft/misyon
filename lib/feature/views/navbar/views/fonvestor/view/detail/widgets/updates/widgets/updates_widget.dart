part of '../updates_view.dart';

class UpdatesWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  UpdatesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildTitle, SizedBox(height: 10.h), _buildUpdates],
      ),
    );
  }

  Widget get _buildTitle => Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: ScaleFactorAutoSizeText(
          text: LocalizationKeys.updatesTextKey.tr,
          style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
            color: AppColors.black,
          ),
        ),
      );
  Widget get _buildUpdates => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            controller.investmentDetail.value?.historyofUpdates?.length ?? 0,
            (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.w),
                child: CustomUpdatesWidget(
                  history: controller.investmentDetail.value?.historyofUpdates?[index],
                  years: controller.investmentDetail.value?.yearsofUpdates?[index],
                  title: controller.investmentDetail.value?.updatesTitle?[index],
                  description: controller.investmentDetail.value?.updatesDescription?[index] ?? "",
                ),
              );
            },
          ),
        ),
      );
}

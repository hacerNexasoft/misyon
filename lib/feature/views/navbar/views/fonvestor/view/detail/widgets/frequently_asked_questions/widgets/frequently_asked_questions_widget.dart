part of '../frequently_asked_questions_view.dart';

class FrequentlyAskedQuestionsWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  FrequentlyAskedQuestionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              _buildTitle,
              SizedBox(
                height: 25.h,
              ),
            ] +
            (List.generate(
                controller.selectedProjectFaqList!.length,
                (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: CustomDetailWidget(
                        tag: 'Frequently$index',
                        title: controller.selectedProjectFaqList![index].question,
                        showBorder: false,
                        child: ScaleFactorAutoSizeText(
                          text: controller.selectedProjectFaqList![index].answer,
                          style: theme.primaryTextTheme.bodyMedium?.copyWith(
                            color: AppColors.hintColor,
                          ),
                        ),
                      ),
                    ))) +
            [SizedBox(height: 20.h)],
      ),
    );
  }

  Widget get _buildTitle => Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: ScaleFactorAutoSizeText(
          text: LocalizationKeys.faqTextKey.tr,
          style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
            color: AppColors.black,
          ),
        ),
      );
}

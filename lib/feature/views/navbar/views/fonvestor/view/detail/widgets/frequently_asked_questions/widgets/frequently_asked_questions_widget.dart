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
          CustomDetailWidget(
            tag: 'Frequently',
            title: LocalizationKeys.faqTitleTextKey.tr,
            showBorder: false,
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomDetailWidget(
            tag: 'Frequently1',
            title: LocalizationKeys.faqTitleTextKey.tr,
            showBorder: false,
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomDetailWidget(
            tag: 'Frequently2',
            title: LocalizationKeys.faqTitleTextKey.tr,
            showBorder: false,
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomDetailWidget(
            tag: 'Frequently3',
            title: LocalizationKeys.faqTitleTextKey.tr,
            showBorder: false,
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomDetailWidget(
            tag: 'Frequently4',
            title: LocalizationKeys.faqTitleTextKey.tr,
            showBorder: false,
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomDetailWidget(
            tag: 'Frequently5',
            title: LocalizationKeys.faqTitleTextKey.tr,
            showBorder: false,
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomDetailWidget(
            tag: 'Frequently6',
            title: LocalizationKeys.faqTitleTextKey.tr,
            showBorder: false,
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomDetailWidget(
            tag: 'Frequently7',
            title: LocalizationKeys.faqTitleTextKey.tr,
            showBorder: false,
            child: ScaleFactorAutoSizeText(
              text:
                  "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: AppColors.hintColor,
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
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

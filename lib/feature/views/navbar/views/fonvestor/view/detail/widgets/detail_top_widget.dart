part of '../detail_view.dart';

class DetailTopWidget extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();

  DetailTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildTitleTop,
        SizedBox(height: 10.h),
        _buildDetailTop,
        SizedBox(height: 50.h),
      ],
    );
  }

  Widget get _buildTitleTop => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleFactorAutoSizeText(
              text: controller.selectedProjectDetails!.name,
              style: theme.primaryTextTheme.headlineMedium!.semibold.copyWith(
                color: AppColors.black,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            HtmlWidget(
              controller.selectedProjectDetails!.description,
              textStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: AppColors.primaryGreyColor,
              ),
            ),
            /*ScaleFactorAutoSizeText(
              text: controller.selectedProjectDetails!.description,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: AppColors.primaryGreyColor,
              ),
            ),*/
          ],
        ),
      );
  Widget get _buildDetailTop => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          SizedBox(
            width: Get.width,
            height: 300.h,
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller.pageController,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final imageUrl = controller.selectedProjectSummary!.coverImage;
                    return imageUrl == null
                        ? const SizedBox.shrink()
                        : Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: Get.width,
                            height: 300.h,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) {
                                return child;
                              } else {
                                return const Center(child: LoadingWidget());
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.error, color: Colors.red),
                              );
                            },
                          );
                  },
                  onPageChanged: (index) {
                    controller.currentPage.value = index;
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.w),
                    child: SmoothPageIndicator(
                      controller: controller.pageController,
                      count: 1,
                      effect: ScaleEffect(
                        dotWidth: 8.h,
                        dotHeight: 8.h,
                        spacing: 5.h,
                        dotColor: AppColors.white,
                        activeDotColor: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

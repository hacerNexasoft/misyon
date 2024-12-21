part of '../../explore_view.dart';

class UpdateListWidget extends BaseStatelessWidget {
  final controller = Get.find<ExploreViewController>();

  UpdateListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => _viewContent,
      onLoading: const LoadingWidget(),
      onEmpty: EmptyWidget(
        image: AssetConstants.emptyItemIcon,
        text: LocalizationKeys.emptySearchTextKey.tr,
        size: 75.h,
      ),
      onError: (error) => ScaleFactorAutoSizeText(text: error.toString()),
    );
  }

  Widget get _viewContent => Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 0.w),
          itemCount: controller.communityList.length,
          itemBuilder: (context, index) {
            final item = controller.communityList[index];
            return UpdateListItemWidget(
              imageUrl: item?.imageUrl,
              name: item?.projectName,
              date: item?.date,
              updatesSubTitle: item?.updatesSubTitle,
              updatesTitle: item?.updates,
              onTap: () => Get.toNamed(
                AppRoutes.detailView,
                arguments: {
                  'projectName': item?.projectName,
                },
              ),
            );
          },
        ),
      );
}

part of '../../explore_view.dart';

class InvestmentsListWidget extends BaseStatelessWidget {
  final controller = Get.find<ExploreViewController>();

  InvestmentsListWidget({super.key});

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
          padding: EdgeInsets.only(bottom: 150.w),
          itemCount: controller.communityList.length,
          itemBuilder: (context, index) {
            final item = controller.communityList[index];
            return _InvestmentsListItemWidget(
                imageUrl: item?.imageUrl,
                name: item?.projectName,
                minutes: item?.minutes,
                amount: item?.amount,
                textColor: item?.investment!.getColorTextExploreInvestment,
                color: item?.investment!.getColorExploreInvestment,
                label: item?.investment!.getStringExploreInvestment,
                ceo: item?.ceo,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.detailView,
                    arguments: {
                      'projectName': item?.projectName,
                    },
                  );
                });
          },
        ),
      );
}

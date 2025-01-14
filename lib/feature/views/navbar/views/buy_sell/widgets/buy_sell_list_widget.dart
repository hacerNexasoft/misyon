part of '../buy_sell_view.dart';

class _BuySellListWidget extends BaseGetView<BuySellViewController> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 20.w),
        itemCount: controller.selectedList.length,
        itemBuilder: (context, index) {
          final list = controller.selectedList;
          final item = list[index];
          return Padding(
            padding:
                EdgeInsets.only(bottom: (index == list.length - 1 ? 0 : 20).w),
            child: ProjectCardComp(
              projectModel: item,
              infoText: "", //'Son ${item.maturity} Gün',
              image: item.imageUrl.toString(),
            ),
          );
        },
      ),
    );
  }
}

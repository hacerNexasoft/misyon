part of '../../investments_view.dart';

class _InvestmentsListWidget extends BaseGetView<InvestmentsViewController> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 10.w),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.investmentsItemList.length,
      itemBuilder: (context, index) {
        final item = controller.investmentsItemList[index];
        return _InvestmentsListItemWidget(investmentsItemModel: item);
      },
    );
  }
}

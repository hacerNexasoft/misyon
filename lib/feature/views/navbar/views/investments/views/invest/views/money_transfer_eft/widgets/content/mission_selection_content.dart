part of '../../../../invest_view.dart';

class _MissionSelectionContent extends BaseStatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          _InvestAmountWidget(),
          _WarningsWidget(),
        ],
      ),
    );
  }
}

part of '../fonvestor_view.dart';

class _CommunityWidget extends BaseStatelessWidget {
  final String headerTitle;
  final List<CommunityItemModel?> communityItemModel;

  const _CommunityWidget({
    required this.headerTitle,
    required this.communityItemModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InvestmentCardHeaderComp(headerTitile: headerTitle),
        SizedBox(height: 20.h),
        _buildList()
      ],
    );
  }

  Widget _buildList() {
    return SizedBox(
      height: 86.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: communityItemModel.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
              left: 10.w,
              right: (index == communityItemModel.length - 1 ? 10 : 0).w),
          child: communityItemModel[index] != null
              ? CommunityCardComp(
                  communityItemModel: communityItemModel[index]!,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

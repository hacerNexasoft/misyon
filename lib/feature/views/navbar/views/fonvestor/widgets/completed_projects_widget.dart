part of '../fonvestor_view.dart';

class _CompletedProjectsWidget extends BaseStatelessWidget {
  final String headerTitle;
  final List<InvestmentModel?> projects;

  const _CompletedProjectsWidget({
    required this.headerTitle,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InvestmentCardHeaderComp(headerTitile: headerTitle),
        SizedBox(height: 20.h),
        _buildList(),
      ],
    );
  }

  Widget _buildList() {
    return SizedBox(
      height: 130.sp,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: projects.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
              left: 0.w, right: (index == projects.length - 1 ? 0 : 0).w),
          child: projects[index] != null
              ? InvestmentCompletedComp(
                  projectModel: projects[index]!,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

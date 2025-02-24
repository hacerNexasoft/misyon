import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/components/project_card_comp/project_card_comp.dart';
import 'package:misyonbank/feature/components/project_card_comp/project_card_header_comp.dart';
import 'package:misyonbank/product/models/project/project_model.dart';

class HorizontalProjectListComp extends BaseStatelessWidget {
  final String headerTitle;
  final List<ProjectModel> projects;

  const HorizontalProjectListComp({super.key, required this.headerTitle, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ProjectCardHeaderComp(headerTitle: headerTitle),
        SizedBox(height: 20.h),
        _buildList(),
      ],
    );
  }

  Widget _buildList() {
    double listHeight =
        projects.any((project) => project.status == ProjectStatus.upcomingDetailedPrerelease)
            ? 200.sp
            : 250.sp;

    return SizedBox(
      height: listHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: projects.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(left: 10.w, right: (index == projects.length - 1 ? 10 : 0).w),
          child: Builder(builder: (context) {
            return ProjectCardComp(
              image: projects.elementAt(index).coverImage.toString(),
              projectModel: projects[index],
            );
          }),
        ),
      ),
    );
  }
}

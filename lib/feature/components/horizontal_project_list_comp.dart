import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/components/project_card_comp/project_card_comp.dart';
import 'package:misyonbank/feature/components/project_card_comp/project_card_header_comp.dart';
import 'package:misyonbank/product/models/project/project_model.dart';

class HorizontalProjectListComp extends BaseStatelessWidget {
  final String headerTitle;
  final List<ProjectModel> projects;

  const HorizontalProjectListComp(
      {super.key, required this.headerTitle, required this.projects});

  String statusText(
      {required ProjectStatus status, required Duration duration}) {
    if (duration.inDays > 0) {
      return "${duration.inDays} Gün Kaldı";
    } else if (duration.inHours > 0) {
      return "${duration.inHours} Saat Kaldı";
    } else if (duration.inMinutes > 0) {
      return "${duration.inMinutes} Dakika Kaldı";
    } else {
      switch (status) {
        case ProjectStatus.activeFunding:
          return "Fonlamada";
        case ProjectStatus.activeFundingStopped:
          return "Fonlama Sona Erdi";

        case ProjectStatus.successful:
          return "Başarılı";
        case ProjectStatus.upcomingPreview:
          return "Çok Yakında"; //LocalizationKeys.completionStatusTextKey.tr;
        case ProjectStatus.upcomingDetailedPrerelease:
          return "Çok Yakında";
        case ProjectStatus.upcomingPrerelease:
          return "Çok Yakında";

        default:
          return "";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ProjectCardHeaderComp(headerTitile: headerTitle),
        SizedBox(height: 20.h),
        _buildList(),
      ],
    );
  }

  Widget _buildList() {
    double listHeight =
        projects.any((project) => project.status == ProjectStatus.activeFunding)
            ? 250.sp
            : 250.sp; // Burada sıkıntı çıkabilir!!

    return SizedBox(
      height: listHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: projects.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
              left: 10.w, right: (index == projects.length - 1 ? 10 : 0).w),
          child: Builder(builder: (context) {
            Duration duration = DateTime.fromMillisecondsSinceEpoch(
                    projects[index].projectEndDate)
                .difference(DateTime.now());
            if (kDebugMode) {
              print("Duration:$duration");
            }
            return ProjectCardComp(
              infoText: statusText(
                  status: projects[index].status, duration: duration),
              image: projects.elementAt(index).coverImage.toString(),
              projectModel: projects[index],
            );
          }),
        ),
      ),
    );
  }
}

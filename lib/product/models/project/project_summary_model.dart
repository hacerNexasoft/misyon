import 'package:common/common.dart';
import 'package:misyonbank/product/utils/model_helpers.dart';

class ProjectSummaryModel {
  final String projectID;
  final String? category;
  final String shortDescription;
  final String title;
  final String projectCode;
  final String? videoUrl;
  final List<String>? tags;
  final String? coverImage;
  final String? logo;
  final ProjectStatus status;
  final bool isFavorite;
  final bool canPreInvestment;

  ProjectSummaryModel(
      {required this.projectID,
      required this.category,
      required this.shortDescription,
      required this.title,
      required this.projectCode,
      required this.videoUrl,
      required this.tags,
      required this.coverImage,
      required this.logo,
      required this.status,
      required this.isFavorite,
      required this.canPreInvestment});

  factory ProjectSummaryModel.fromJson({required Map<String, dynamic> json}) => ProjectSummaryModel(
        projectID: json["id"],
        category: json["category"],
        shortDescription: json["shortDescription"],
        title: json["title"],
        projectCode: json["projectCode"],
        videoUrl: json["videoUrl"],
        tags: json["tags"] != null ? List<String>.from(json["tags"]) : null,
        coverImage: json["coverImage"],
        logo: json["logo"],
        status: ModelHelpers.findProjectStatusByCode(json["status"]),
        isFavorite: json["isFavorite"],
        canPreInvestment: json["canPreInvestment"],
      );
}

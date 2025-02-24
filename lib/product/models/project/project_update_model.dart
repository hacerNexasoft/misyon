import 'package:misyonbank/product/models/project/project_documents_model.dart';

class ProjectUpdateModel {
  final String title;
  final String description;
  final int updateDate;
  final int status;
  final List<Document> documents;

  ProjectUpdateModel({
    required this.title,
    required this.description,
    required this.updateDate,
    required this.status,
    required this.documents,
  });

  factory ProjectUpdateModel.fromJson(Map<String, dynamic> json) {
    return ProjectUpdateModel(
      title: json['title'],
      description: json['description'],
      updateDate: json['updateDate'],
      status: json['status'],
      documents: List<Document>.from(json['documents'].map((x) => Document.fromJson(x))),
    );
  }
}

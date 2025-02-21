class ProjectDocumentsModel {
  List<Document> platformDocuments;
  List<Document> projectDocuments;

  ProjectDocumentsModel({required this.platformDocuments, required this.projectDocuments});

  factory ProjectDocumentsModel.fromJson(Map<String, dynamic> json) {
    return ProjectDocumentsModel(
      platformDocuments: (json['platformDocuments'] as List<dynamic>?)
              ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      projectDocuments: (json['projectDocuments'] as List<dynamic>?)
              ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class Document {
  String documentId;
  String mimeType;
  String name;

  Document({required this.documentId, required this.mimeType, required this.name});

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      documentId: json['documentId'] as String,
      mimeType: json['mimeType'] as String,
      name: json['name'] as String,
    );
  }
}

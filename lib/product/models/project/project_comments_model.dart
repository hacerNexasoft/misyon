class ProjectCommentsModel {
  final String id;
  final int status;
  final int commentDate;
  final String name;
  final String comment;
  final List<ProjectCommentsModel> childComment;

  ProjectCommentsModel({
    required this.id,
    required this.status,
    required this.commentDate,
    required this.name,
    required this.comment,
    required this.childComment,
  });

  factory ProjectCommentsModel.fromJson(Map<String, dynamic> json) {
    return ProjectCommentsModel(
      id: json['id'] ?? '',
      status: json['status'] ?? 0,
      commentDate: json['commentDate'] ?? 0,
      name: json['name'] ?? '',
      comment: json['comment'] ?? '',
      childComment: (json['childComment'] as List<dynamic>?)
              ?.map((e) => ProjectCommentsModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ProjectTrophiesModel {
  final String id;
  final String title;
  final String description;

  ProjectTrophiesModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory ProjectTrophiesModel.fromJson(Map<String, dynamic> json) {
    return ProjectTrophiesModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}

class ProjectCreateHighlightsModel {
  String id;
  String title;
  String description;

  ProjectCreateHighlightsModel({
    required this.id,
    required this.title,
    required this.description,
  });

  // JSON'dan nesne dönüştürme metodu
  factory ProjectCreateHighlightsModel.fromJson(Map json) {
    return ProjectCreateHighlightsModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  // Nesneyi JSON'a dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}

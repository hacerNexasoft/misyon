class ProjectFilterModel {
  final List<int> stateFilters;
  final List<String> categories;
  final List<String> cities;
  final PageInfo pageInfo;

  ProjectFilterModel({
    required this.stateFilters,
    required this.categories,
    required this.cities,
    required this.pageInfo,
  });

  // JSON'dan nesneye dönüştürme
  factory ProjectFilterModel.fromJson(Map<String, dynamic> json) {
    return ProjectFilterModel(
      stateFilters: List<int>.from(json['stateFilters'] ?? []),
      categories: List<String>.from(json['categories'] ?? []),
      cities: List<String>.from(json['cities'] ?? []),
      pageInfo: PageInfo.fromJson(json['pageInfo'] ?? {}),
    );
  }

  // Nesneden JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'stateFilters': stateFilters,
      'categories': categories,
      'cities': cities,
      'pageInfo': pageInfo.toJson(),
    };
  }

  // Null kontrolü
  bool hasNullFields() {
    return stateFilters.isEmpty || categories.isEmpty || cities.isEmpty;
  }
}

class PageInfo {
  final int pageNumber;
  final int count;

  PageInfo({
    required this.pageNumber,
    required this.count,
  });

  // JSON'dan nesneye dönüştürme
  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      pageNumber: json['pageNumber'] ?? 0,
      count: json['count'] ?? 0,
    );
  }

  // Nesneden JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'pageNumber': pageNumber,
      'count': count,
    };
  }
}

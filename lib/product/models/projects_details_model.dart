class ProjectDetailsModel {
  final String id;
  final String category;
  final String city;
  final String coverImage;
  final double fundedAmount;
  final double fundingGoal;
  final double fundingPercentage;
  final String logo;
  final int numberOfInvestors;
  final int projectEndDate;
  final int projectStartDate;
  final String shortDescription;
  final int status;
  final int timeUntilEnd;
  final int timeUntilStart;
  final String title;
  final String externalId;
  final String seoName;
  final bool isClickable;
  final bool isFavorite;

  ProjectDetailsModel({
    required this.id,
    required this.category,
    required this.city,
    required this.coverImage,
    required this.fundedAmount,
    required this.fundingGoal,
    required this.fundingPercentage,
    required this.logo,
    required this.numberOfInvestors,
    required this.projectEndDate,
    required this.projectStartDate,
    required this.shortDescription,
    required this.status,
    required this.timeUntilEnd,
    required this.timeUntilStart,
    required this.title,
    required this.externalId,
    required this.seoName,
    required this.isClickable,
    required this.isFavorite,
  });

  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailsModel(
      id: json['id'] ?? '', // Null kontrolü ile varsayılan değer ataması
      category:
          json['category'] ?? '', // Null kontrolü ile varsayılan değer ataması
      city: json['city'] ?? '', // Null kontrolü ile varsayılan değer ataması
      coverImage: json['coverImage'] ??
          '', // Null kontrolü ile varsayılan değer ataması
      fundedAmount: json['fundedAmount']?.toDouble() ?? 0.0,
      fundingGoal: json['fundingGoal']?.toDouble() ?? 0.0,
      fundingPercentage: json['fundingPercentage']?.toDouble() ?? 0.0,
      logo: json['logo'] ?? '', // Null kontrolü ile varsayılan değer ataması
      numberOfInvestors: json['numberOfInvestors'] ??
          0, // Null kontrolü ile varsayılan değer ataması
      projectEndDate: json['projectEndDate'] ??
          0, // Null kontrolü ile varsayılan değer ataması
      projectStartDate: json['projectStartDate'] ??
          0, // Null kontrolü ile varsayılan değer ataması
      shortDescription: json['shortDescription'] ??
          '', // Null kontrolü ile varsayılan değer ataması
      status: json['status'] ?? 0, // Null kontrolü ile varsayılan değer ataması
      timeUntilEnd: json['timeUntilEnd'] ??
          0, // Null kontrolü ile varsayılan değer ataması
      timeUntilStart: json['timeUntilStart'] ??
          0, // Null kontrolü ile varsayılan değer ataması
      title: json['title'] ?? '', // Null kontrolü ile varsayılan değer ataması
      externalId: json['externalId'] ??
          '', // Null kontrolü ile varsayılan değer ataması
      seoName:
          json['seoName'] ?? '', // Null kontrolü ile varsayılan değer ataması
      isClickable: json['isClickable'] ??
          false, // Null kontrolü ile varsayılan değer ataması
      isFavorite: json['isFavorite'] ??
          false, // Null kontrolü ile varsayılan değer ataması
    );
  }
}

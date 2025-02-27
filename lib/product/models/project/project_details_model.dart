class ProjectDetailsModel {
  final String projectID;
  final bool isCorporate;
  final int? foundingYear;
  final int? numberOfEmployees;
  final double partnershipPercentage;
  final String? entreprenuerPicture;
  final String name;
  final String mail;
  final String? linkedinUrl;
  final String? facebookUrl;
  final String? projectUrl;
  final String title;
  final String? executive;
  final String? address;
  final String description;

  const ProjectDetailsModel({
    required this.projectID,
    required this.isCorporate,
    required this.foundingYear,
    required this.numberOfEmployees,
    required this.partnershipPercentage,
    required this.entreprenuerPicture,
    required this.name,
    required this.mail,
    required this.linkedinUrl,
    required this.facebookUrl,
    required this.projectUrl,
    required this.title,
    required this.executive,
    required this.address,
    required this.description,
  });

  factory ProjectDetailsModel.fromJson({required String id, required Map<String, dynamic> json}) =>
      ProjectDetailsModel(
        projectID: id,
        isCorporate: json["isCorporate"],
        foundingYear: json["foundingYear"],
        numberOfEmployees: json["numberOfEmployees"],
        partnershipPercentage: json["partnershipPercentage"] ?? 0.0,
        entreprenuerPicture: json["entreprenuerPicture"],
        name: json["name"],
        mail: json["mail"],
        facebookUrl: json["facebookUrl"] ?? "",
        linkedinUrl: json["linkedinUrl"] ?? "",
        projectUrl: json["projectUrl"] ?? "",
        title: json["title"] ?? "",
        executive: json["executive"] ?? "",
        address: json["address"] ?? "",
        description: json["description"] ?? "",
      );

  /*Map<String, dynamic> toJson() => {
        "id": id ?? "",
        
        
        "projectSubtitle": numberOfEmployees ?? "",
        "amount": partnershipPercentage ?? "",
        "investment": entreprenuerPicture,
        "minutes": name ?? "",
        "updates": mail ?? "",
        "date": facebookUrl ?? "",
        "updatesSubTitle": linkedinUrl ?? "",
      };*/
}

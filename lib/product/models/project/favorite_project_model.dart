class FavoriteProjectModel {
  final String projectId;
  final String logo;
  final String name;
  final int stateCode;
  final double fundingPercentage;
  final double fundingGoal;
  final double? fundedAmount;
  final double transferredFund;
  final String projectExternalId;
  final String seoName;

  FavoriteProjectModel({
    required this.projectId,
    required this.logo,
    required this.name,
    required this.stateCode,
    required this.fundingPercentage,
    required this.fundingGoal,
    this.fundedAmount,
    required this.transferredFund,
    required this.projectExternalId,
    required this.seoName,
  });

  factory FavoriteProjectModel.fromJson(Map<String, dynamic> json) {
    return FavoriteProjectModel(
      projectId: json['projectId'],
      logo: json['logo'],
      name: json['name'],
      stateCode: json['stateCode'],
      fundingPercentage: json['fundingPercentage'].toDouble(),
      fundingGoal: json['fundingGoal'].toDouble(),
      fundedAmount: json['fundedAmount']?.toDouble(),
      transferredFund: json['transferredFund'].toDouble(),
      projectExternalId: json['projectExternalId'],
      seoName: json['seoName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'projectId': projectId,
        'logo': logo,
        'name': name,
        'stateCode': stateCode,
        'fundingPercentage': fundingPercentage,
        'fundingGoal': fundingGoal,
        'fundedAmount': fundedAmount,
        'transferredFund': transferredFund,
        'projectExternalId': projectExternalId,
        'seoName': seoName,
      };
}

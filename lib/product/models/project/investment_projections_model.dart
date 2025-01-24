class InvestmentProjection {
  String investmentProjectionId;
  String? projectExternalId;
  double investmentProjectionRate;
  String investmentProjectionName;

  InvestmentProjection({
    required this.investmentProjectionId,
    this.projectExternalId,
    required this.investmentProjectionRate,
    required this.investmentProjectionName,
  });

  // JSON'dan nesne dönüştürme metodu
  factory InvestmentProjection.fromJson(Map json) {
    return InvestmentProjection(
      investmentProjectionId: json['investmentProjectionId'],
      projectExternalId: json['projectExternalId'],
      investmentProjectionRate: json['investmentProjectionRate'],
      investmentProjectionName: json['investmentProjectionName'],
    );
  }

  // Nesneyi JSON'a dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'investmentProjectionId': investmentProjectionId,
      'projectExternalId': projectExternalId,
      'investmentProjectionRate': investmentProjectionRate,
      'investmentProjectionName': investmentProjectionName,
    };
  }
}

import 'package:common/common.dart';
import 'package:misyonbank/product/utils/model_helpers.dart';

class ProjectModel {
  final String id;
  final String category;
  final String city;
  final String coverImage;
  final double fundedAmount;
  final double fundingGoal;
  final double fundingPercentage;
  final String logoUrl;
  final int numberOfInvestors;
  final int projectEndDate;
  final int projectStartDate;
  final String shortDescription;
  final int statusCode;
  final ProjectStatus status;
  final int timeUntilEnd;
  final int timeUntilStart;
  final String title;
  final String externalId;
  final String seoName;
  final bool isClickable;
  final bool isFavorite;
  final int termCode;
  final int periodCode;
  final Period period;
  final double yearlyReturnRate;
  final CollateralStructure collateralStructure;
  final RiskType? riskForDebit;

  ProjectModel({
    required this.id,
    required this.category,
    required this.city,
    required this.coverImage,
    required this.fundedAmount,
    required this.fundingGoal,
    required this.fundingPercentage,
    required this.logoUrl,
    required this.numberOfInvestors,
    required this.projectEndDate,
    required this.projectStartDate,
    required this.shortDescription,
    required this.statusCode,
    required this.status,
    required this.timeUntilEnd,
    required this.timeUntilStart,
    required this.title,
    required this.externalId,
    required this.seoName,
    required this.isClickable,
    required this.isFavorite,
    required this.termCode,
    required this.period,
    required this.periodCode,
    required this.yearlyReturnRate,
    required this.collateralStructure,
    required this.riskForDebit,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
        id: json['id'] ?? '', // Null kontrolü ile varsayılan değer ataması
        category: json['category'] ?? '', // Null kontrolü ile varsayılan değer ataması
        city: json['city'] ?? '', // Null kontrolü ile varsayılan değer ataması
        coverImage: json['coverImage'] ?? '', // Null kontrolü ile varsayılan değer ataması
        fundedAmount: json['fundedAmount']?.toDouble() ?? 0.0,
        fundingGoal: json['fundingGoal']?.toDouble() ?? 0.0,
        fundingPercentage: json['fundingPercentage']?.toDouble() ?? 0.0,
        logoUrl: json['logo'] ?? '', // Null kontrolü ile varsayılan değer ataması
        numberOfInvestors:
            json['numberOfInvestors'] ?? 0, // Null kontrolü ile varsayılan değer ataması
        projectEndDate: json['projectEndDate'] ?? 0, // Null kontrolü ile varsayılan değer ataması
        projectStartDate:
            json['projectStartDate'] ?? 0, // Null kontrolü ile varsayılan değer ataması
        shortDescription:
            json['shortDescription'] ?? '', // Null kontrolü ile varsayılan değer ataması
        statusCode: json['status'] ?? 0, // Null kontrolü ile varsayılan değer ataması
        status: ModelHelpers.findProjectStatusByCode(json['status'] ?? 0),
        timeUntilEnd: json['timeUntilEnd'] ?? 0, // Null kontrolü ile varsayılan değer ataması
        timeUntilStart: json['timeUntilStart'] ?? 0, // Null kontrolü ile varsayılan değer ataması
        title: json['title'] ?? '', // Null kontrolü ile varsayılan değer ataması
        externalId: json['externalId'] ?? '', // Null kontrolü ile varsayılan değer ataması
        seoName: json['seoName'] ?? '', // Null kontrolü ile varsayılan değer ataması
        isClickable: json['isClickable'] ?? false, // Null kontrolü ile varsayılan değer ataması
        isFavorite: json['isFavorite'] ?? false, // Null kontrolü ile varsayılan değer ataması
        termCode: json['term'] ?? 0,
        periodCode: json['period'] ?? 0,
        period: ModelHelpers.findPeriodByCode(json['collateralStructure'] ?? 0),
        yearlyReturnRate: json['yearlyReturnRate'] ?? 0,
        collateralStructure:
            ModelHelpers.findCollateralStructureByCode(json['collateralStructure'] ?? 0),
        riskForDebit:
            json['riskForDbit'] == null ? null : ModelHelpers.findRiskType(json['riskForDbit']));
  }
}

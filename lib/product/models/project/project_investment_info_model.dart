import 'package:common/common.dart';
import 'package:misyonbank/product/utils/model_helpers.dart';

class ProjectInvestmentInfoModel {
  final String projectID;
  final int projectStartDate;
  final int projectEndDate;
  final double fundedAmount;
  final double extraFundingAmount;
  final double fundingGoal;
  final double fundingPercentage;
  final double additionalFundingRate;
  final ProjectStatus status;
  final int numberOfInvestors;
  final int timeUntilEnd; // In minutes
  final int timeUntilStart; // In minutes
  final bool canInvestable;
  final bool showCountdown;

  ProjectInvestmentInfoModel(
      {required this.projectID,
      required this.projectStartDate,
      required this.projectEndDate,
      required this.fundedAmount,
      required this.extraFundingAmount,
      required this.fundingGoal,
      required this.fundingPercentage,
      required this.additionalFundingRate,
      required this.status,
      required this.numberOfInvestors,
      required this.timeUntilEnd,
      required this.timeUntilStart,
      required this.canInvestable,
      required this.showCountdown});

  factory ProjectInvestmentInfoModel.fromJson(
          {required String projectID, required Map<String, dynamic> json}) =>
      ProjectInvestmentInfoModel(
        projectID: projectID,
        projectStartDate: json["projectStartDate"],
        projectEndDate: json["projectEndDate"],
        fundedAmount: json["fundedAmount"],
        extraFundingAmount: json["extraFundingAmount"],
        fundingGoal: json["fundingGoal"],
        fundingPercentage: json["fundingPercentage"],
        additionalFundingRate: json["additionalFundingRate"],
        status: ModelHelpers.findStatusByCode(json["status"]),
        numberOfInvestors: json["numberOfInvestors"],
        timeUntilEnd: json["timeUntilEnd"],
        timeUntilStart: json["timeUntilStart"],
        canInvestable: json["canInvestable"],
        showCountdown: json["showCountdown"],
      );
}

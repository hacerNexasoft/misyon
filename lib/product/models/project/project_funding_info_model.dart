import 'package:common/common.dart';
import 'package:misyonbank/product/models/investable_model.dart';
import 'package:misyonbank/product/utils/model_helpers.dart';

class ProjectFundingInfoModel {
  final String projectID;
  final int projectStartDate;
  final int projectEndDate;
  final int projectFundingCloseDate;
  final double fundingGoal;
  final double percentageofShares;
  final int numberofShares;
  final double additionalFundingRate;
  final double unitShareValue;
  final double postInvestmentCompanyValue;
  final List<int> coefficients;
  final int? term;
  final Period? period;
  final double? yearlyReturnRate;
  final CollateralStructure? collateralStructure;
  final InvestableModel investableStatus;
  final String? projectDuration;
  final RiskType? riskType;
  final double? riskValue;

  ProjectFundingInfoModel({
    required this.projectID,
    required this.projectStartDate,
    required this.projectEndDate,
    required this.projectFundingCloseDate,
    required this.fundingGoal,
    required this.percentageofShares,
    required this.numberofShares,
    required this.additionalFundingRate,
    required this.unitShareValue,
    required this.postInvestmentCompanyValue,
    required this.coefficients,
    required this.term,
    required this.period,
    required this.yearlyReturnRate,
    required this.collateralStructure,
    required this.investableStatus,
    required this.projectDuration,
    required this.riskType,
    required this.riskValue,
  });

  factory ProjectFundingInfoModel.fromJson(
          {required String projectID, required Map<String, dynamic> json}) =>
      ProjectFundingInfoModel(
        projectID: projectID,
        projectStartDate: json["projectStartDate"],
        projectEndDate: json["projectEndDate"],
        projectFundingCloseDate: json["projectFundingCloseDate"],
        fundingGoal: json["fundingGoal"],
        percentageofShares: json["percentageofShares"],
        numberofShares: json["numberofShares"],
        additionalFundingRate: json["additionalFundingRate"],
        unitShareValue: json["unitShareValue"],
        postInvestmentCompanyValue: json["postInvestmentCompanyValue"],
        coefficients: List<int>.from(json["coefficients"]),
        term: json["term"],
        period: json["period"] != null ? ModelHelpers.findPeriodByCode(json["period"]) : null,
        yearlyReturnRate: json["yearlyReturnRate"],
        collateralStructure: json["collateralStructure"] != null
            ? ModelHelpers.findCollateralStructureByCode(json["collateralStructure"])
            : null,
        investableStatus: InvestableModel.fromJson(json: json["investableStatus"]),
        projectDuration: json["projectDuration"],
        riskType:
            json["riskForDbit"] != null ? ModelHelpers.findRiskType(json["riskForDbit"]) : null,
        riskValue: json["riskForDbit"],
      );
}

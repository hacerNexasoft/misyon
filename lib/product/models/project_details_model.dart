import 'package:misyonbank/product/models/base_model.dart';

class ProjectDetailModel extends BaseModel {
  final String? id;
  final String? title;
  final String? subtitle;
  final List<String>? imageUrl;
  final double? fundRaised;
  final double? targetFund;
  final String? remainingDay;
  final String? investment;
  final String? completed;
  final String? maturity;
  final String? rateofReturn;
  final String? returnFrequency;
  final double? valuation;
  final String? companyValue;
  final int? minimumInvestmentAmount;
  final double? minimumfundingGoal;
  final double? maxfundingGoal;
  final String? deadLine;
  final List<String>? platformDocuments;
  final List<String>? campaignDocuments;
  final List<String>? teamImageUrl;
  final List<String>? teamName;
  final List<String>? teamrole;
  final String? companyName;
  final String? foundationYear;
  final String? chairman;
  final String? numberofEmployees;
  final String? companyAddress;
  final String? problem;
  final String? competitorAnalysis;
  final String? market;
  final String? incomePlan;
  final String? solution;
  final String? additionalReward;
  final List<String>? tags;
  final int? risk;
  final String? startDate;
  final String? finishDate;
  final String? stopDate;
  final String? lot;
  final String? percent;
  final String? sharePcs;
  final String? additionalFundRate;
  final String? additionalAmount;
  final String? collateralStructure;
  final String? companyValues;
  final List<String>? incomeStatementTitle;
  final List<double>? incomeStatementData;
  final List<String>? balanceSheetTitle;
  final List<double>? balanceSheetData;
  final List<String>? historyofUpdates;
  final List<String>? yearsofUpdates;
  final List<String>? updatesTitle;
  final List<String>? updatesDescription;
  final List<String>? teamsInfo;

  ProjectDetailModel({
    this.id,
    this.teamsInfo,
    this.title,
    this.risk,
    this.subtitle,
    this.imageUrl,
    this.fundRaised,
    this.rateofReturn,
    this.targetFund,
    this.remainingDay,
    this.startDate,
    this.finishDate,
    this.stopDate,
    this.lot,
    this.percent,
    this.sharePcs,
    this.additionalFundRate,
    this.additionalAmount,
    this.collateralStructure,
    this.companyValues,
    this.investment,
    this.completed,
    this.maturity,
    this.returnFrequency,
    this.valuation,
    this.companyValue,
    this.minimumInvestmentAmount,
    this.minimumfundingGoal,
    this.maxfundingGoal,
    this.deadLine,
    this.platformDocuments,
    this.campaignDocuments,
    this.teamImageUrl,
    this.teamName,
    this.teamrole,
    this.companyName,
    this.foundationYear,
    this.chairman,
    this.numberofEmployees,
    this.companyAddress,
    this.problem,
    this.incomePlan,
    this.competitorAnalysis,
    this.market,
    this.solution,
    this.tags,
    this.additionalReward,
    this.incomeStatementTitle,
    this.incomeStatementData,
    this.balanceSheetTitle,
    this.balanceSheetData,
    this.historyofUpdates,
    this.yearsofUpdates,
    this.updatesTitle,
    this.updatesDescription,
  });

  factory ProjectDetailModel.fromJson(Map<String, dynamic> json) =>
      ProjectDetailModel(
          id: json["id"],
          title: json["title"],
          subtitle: json["subtitle"],
          risk: json["risk"],
          teamsInfo: json["teamsInfo"] != null
              ? List<String>.from(json["teamsInfo"])
              : null,
          imageUrl: json["imageUrl"] != null
              ? List<String>.from(json["imageUrl"])
              : null,
          fundRaised: json["fundRaised"],
          targetFund: json["targetFund"],
          remainingDay: json["remainingDay"],
          investment: json["investment"],
          completed: json["completed"],
          maturity: json["maturity"],
          rateofReturn: json["rateofReturn"],
          returnFrequency: json["returnFrequency"],
          valuation: json["valuation"],
          companyValue: json["companyValue"],
          minimumInvestmentAmount: json["minimumInvestmentAmount"],
          minimumfundingGoal: json["minimumfundingGoal"],
          maxfundingGoal: json["maxfundingGoal"],
          deadLine: json["deadLine"],
          platformDocuments: json["platformDocuments"] != null
              ? List<String>.from(json["platformDocuments"])
              : null,
          campaignDocuments: json["campaignDocuments"] != null
              ? List<String>.from(json["campaignDocuments"])
              : null,
          teamImageUrl: json["teamImageUrl"] != null
              ? List<String>.from(json["teamImageUrl"])
              : null,
          teamName: json["teamName"] != null
              ? List<String>.from(json["teamName"])
              : null,
          teamrole: json["teamrole"] != null
              ? List<String>.from(json["teamrole"])
              : null,
          companyName: json["companyName"],
          foundationYear: json["foundationYear"],
          chairman: json["chairman"],
          numberofEmployees: json["numberofEmployees"],
          companyAddress: json["companyAddress"],
          problem: json["problem"],
          incomePlan: json["incomePlan"],
          competitorAnalysis: json["competitorAnalysis"],
          market: json["market"],
          solution: json["solution"],
          tags: json["tags"] != null ? List<String>.from(json["tags"]) : null,
          additionalReward: json["additionalReward"],
          incomeStatementTitle: json["incomeStatementTitle"] != null
              ? List<String>.from(json["incomeStatementTitle"])
              : null,
          startDate: json["startDate"],
          finishDate: json["finishDate"],
          stopDate: json["stopDate"],
          lot: json["lot"],
          percent: json["percent"],
          sharePcs: json["sharePcs"],
          additionalFundRate: json["additionalFundRate"],
          additionalAmount: json["additionalAmount"],
          collateralStructure: json["collateralStructure"],
          companyValues: json["companyValues"],
          incomeStatementData: json["incomeStatementData"] != null
              ? List<double>.from(json["incomeStatementData"])
              : null,
          balanceSheetTitle: json["balanceSheetTitle"] != null
              ? List<String>.from(json["balanceSheetTitle"])
              : null,
          balanceSheetData: json["balanceSheetData"] != null
              ? List<double>.from(json["balanceSheetData"])
              : null,
          historyofUpdates: json["historyofUpdates"] != null
              ? List<String>.from(json["historyofUpdates"])
              : null,
          updatesTitle: json["updatesTitle"] != null
              ? List<String>.from(json["updatesTitle"])
              : null,
          updatesDescription: json["updatesDescription"] != null
              ? List<String>.from(json["updatesDescription"])
              : null,
          yearsofUpdates: json["yearsofUpdates"] != null
              ? List<String>.from(json["yearsofUpdates"])
              : null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "teamsInfo": teamsInfo,
        "risk": risk,
        "startDate": startDate,
        "finishDate": finishDate,
        "stopDate": stopDate,
        "lot": lot,
        "percent": percent,
        "sharePcs": sharePcs,
        "additionalFundRate": additionalFundRate,
        "additionalAmount": additionalAmount,
        "collateralStructure": collateralStructure,
        "companyValues": companyValues,
        "subtitle": subtitle,
        "imageUrl": imageUrl,
        "fundRaised": fundRaised,
        "targetFund": targetFund,
        "maturity": maturity,
        "remainingDay": remainingDay,
        "investment": investment,
        "completed": completed,
        "rateofReturn": rateofReturn,
        "returnFrequency": returnFrequency,
        "valuation": valuation,
        "companyValue": companyValue,
        "minimumInvestmentAmount": minimumInvestmentAmount,
        "minimumfundingGoal": minimumfundingGoal,
        "maxfundingGoal": maxfundingGoal,
        "deadLine": deadLine,
        "platformDocuments": platformDocuments,
        "campaignDocuments": campaignDocuments,
        "teamImageUrl": teamImageUrl,
        "teamrole": teamrole,
        "teamName": teamName,
        "companyName": companyName,
        "foundationYear": foundationYear,
        "chairman": chairman,
        "numberofEmployees": numberofEmployees,
        "companyAddress": companyAddress,
        "problem": problem,
        "incomePlan": incomePlan,
        "competitorAnalysis": competitorAnalysis,
        "market": market,
        "solution": solution,
        "additionalReward": additionalReward,
        "incomeStatementTitle": incomeStatementTitle,
        "incomeStatementData": incomeStatementData,
        "balanceSheetTitle": balanceSheetTitle,
        "balanceSheetData": balanceSheetData,
        "historyofUpdates": historyofUpdates,
        "yearsofUpdates": yearsofUpdates,
        "updatesTitle": updatesTitle,
        "updatesDescription": updatesDescription,
        "tags": tags
      };

  @override
  List<Object?> get props => [
        id,
        title,
        teamsInfo,
        subtitle,
        imageUrl,
        risk,
        startDate,
        stopDate,
        finishDate,
        lot,
        additionalAmount,
        additionalFundRate,
        additionalReward,
        companyValues,
        collateralStructure,
        percent,
        sharePcs,
        fundRaised,
        targetFund,
        maturity,
        remainingDay,
        investment,
        completed,
        rateofReturn,
        returnFrequency,
        valuation,
        companyValue,
        minimumInvestmentAmount,
        deadLine,
        maxfundingGoal,
        minimumfundingGoal,
        platformDocuments,
        campaignDocuments,
        teamImageUrl,
        teamName,
        teamrole,
        companyName,
        foundationYear,
        chairman,
        numberofEmployees,
        companyAddress,
        problem,
        incomePlan,
        market,
        solution,
        companyAddress,
        additionalReward,
        incomeStatementTitle,
        incomeStatementData,
        balanceSheetTitle,
        balanceSheetData,
        historyofUpdates,
        yearsofUpdates,
        updatesTitle,
        updatesDescription,
        tags
      ];
}

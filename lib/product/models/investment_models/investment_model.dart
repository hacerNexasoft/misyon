import 'package:common/common.dart';
import 'package:misyonbank/product/utils/model_helpers.dart';

class InvestmentModel {
  final String investmentId;
  final InvestmentProject project;
  final double committedInvestment;
  final double totalInvestment;
  final double totalRefund;
  final double netAmount;
  final double fundingRate;
  final int statusCode;
  final InvestmentStatus status;
  final DateTime investmentDate;
  final int updatedOn;
  final bool isRefundable;
  final double shareAmount;
  final double mkkCorrectedShareAmount;
  final String? iban;
  final String? referenceNo;
  final int projectstatus;
  final String projectLogoUrl;
  final int investmentStatusGrouped;
  final InvestmentType investmentType;
  final String seoName;
  final String externalId;
  final int term;
  final int period;
  final double yearlyReturnRate;
  final double monthlyReturnTotal;

  InvestmentModel({
    required this.investmentId,
    required this.project,
    required this.committedInvestment,
    required this.totalInvestment,
    required this.totalRefund,
    required this.netAmount,
    required this.fundingRate,
    required this.statusCode,
    required this.status,
    required this.investmentDate,
    required this.updatedOn,
    required this.isRefundable,
    required this.shareAmount,
    required this.mkkCorrectedShareAmount,
    this.iban,
    this.referenceNo,
    required this.projectstatus,
    required this.projectLogoUrl,
    required this.investmentStatusGrouped,
    required this.investmentType,
    required this.seoName,
    required this.externalId,
    required this.term,
    required this.period,
    required this.yearlyReturnRate,
    required this.monthlyReturnTotal,
  });

  factory InvestmentModel.fromJson(Map<String, dynamic> json) {
    return InvestmentModel(
      investmentId: json['investmentId'],
      project: InvestmentProject.fromJson(json['project']),
      committedInvestment: json['committedInvestment'].toDouble(),
      totalInvestment: json['totalInvestment'].toDouble(),
      totalRefund: json['totalRefund'].toDouble(),
      netAmount: json['netAmount'].toDouble(),
      fundingRate: json['fundingRate'].toDouble(),
      statusCode: json['statusCode'],
      status: ModelHelpers.findInvestmentStatusByCode(json['statusCode'] ?? -1),
      investmentDate: DateTime.fromMillisecondsSinceEpoch(json['investmentDate'] * 1000),
      updatedOn: json['updatedOn'],
      isRefundable: json['isRefundable'],
      shareAmount: json['shareAmount'].toDouble(),
      mkkCorrectedShareAmount: json['mkkCorrectedShareAmount'].toDouble(),
      iban: json['iban'],
      referenceNo: json['referenceNo'],
      projectstatus: json['projectstatus'],
      projectLogoUrl: json['projectLogoUrl'],
      investmentStatusGrouped: json['investmentStatusGrouped'],
      investmentType: ModelHelpers.findInvestmentTypeByCode(json['investmentType'] ?? -1),
      seoName: json['seoName'],
      externalId: json['externalId'],
      term: json['term'],
      period: json['period'],
      yearlyReturnRate: json['yearlyReturnRate'].toDouble(),
      monthlyReturnTotal: json['monthlyReturnTotal'].toDouble(),
    );
  }
}

class InvestmentProject {
  final String id;
  final String title;

  InvestmentProject({required this.id, required this.title});

  factory InvestmentProject.fromJson(Map<String, dynamic> json) {
    return InvestmentProject(id: json['key'], title: json['value']);
  }
}

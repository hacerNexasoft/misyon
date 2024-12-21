import 'package:equatable/equatable.dart';

class InvestmentsItemModel extends Equatable {
  final String? id;
  final String? companyId;
  final String? companyName;
  final String? statusName;
  final DateTime? maturityDate; // DateTime olarak vade tarihi
  final double? rateOfReturn;
  final String? rateOfReturnDescription;
  final double? monthlyReturnAmount;
  final int? timeRemainingUntilReturn;
  final double? totalInvestmentAmount;
  final double? lastPrice;
  final String? imageUrl;
  final String? label;
  final double? labelAmount;
  final double? currentEarnings;
  final double? pendingEarnings;
  final double? totalPendingEarnings;
  final String? frequencyOfReturn;

  const InvestmentsItemModel({
    required this.id,
    required this.companyId,
    required this.companyName,
    required this.statusName,
    required this.label,
    required this.labelAmount,
    required this.maturityDate, // DateTime olarak
    required this.rateOfReturn,
    this.rateOfReturnDescription,
    required this.monthlyReturnAmount,
    required this.timeRemainingUntilReturn,
    required this.totalInvestmentAmount,
    required this.lastPrice,
    this.imageUrl,
    this.currentEarnings,
    this.pendingEarnings,
    this.totalPendingEarnings,
    this.frequencyOfReturn,
  });

  factory InvestmentsItemModel.fromJson(Map<String, dynamic> json) =>
      InvestmentsItemModel(
        id: json["id"],
        companyId: json["companyId"],
        companyName: json["companyName"],
        statusName: json["statusName"],
        label: json["label"],
        labelAmount: json["labelAmount"],
        maturityDate: json["maturityDate"] != null
            ? DateTime.parse(
                json["maturityDate"]) // String'den DateTime'a dönüştür
            : null,
        rateOfReturn: json["rateOfReturn"],
        rateOfReturnDescription: json["rateOfReturnDescription"],
        monthlyReturnAmount: json["monthlyReturnAmount"],
        timeRemainingUntilReturn: json["timeRemainingUntilReturn"],
        totalInvestmentAmount: json["totalInvestmentAmount"],
        lastPrice: json["lastPrice"],
        imageUrl: json["imageUrl"],
        currentEarnings: json["currentEarnings"],
        pendingEarnings: json["pendingEarnings"],
        totalPendingEarnings: json["totalPendingEarnings"],
        frequencyOfReturn: json["frequencyOfReturn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyId": companyId,
        "companyName": companyName,
        "statusName": statusName,
        "label": label,
        "labelAmount": labelAmount,
        "maturityDate":
            maturityDate?.toIso8601String(), // DateTime'ı String'e dönüştür
        "rateOfReturn": rateOfReturn,
        "rateOfReturnDescription": rateOfReturnDescription,
        "monthlyReturnAmount": monthlyReturnAmount,
        "timeRemainingUntilReturn": timeRemainingUntilReturn,
        "totalInvestmentAmount": totalInvestmentAmount,
        "lastPrice": lastPrice,
        "imageUrl": imageUrl,
        "currentEarnings": currentEarnings,
        "pendingEarnings": pendingEarnings,
        "totalPendingEarnings": totalPendingEarnings,
        "frequencyOfReturn": frequencyOfReturn,
      };

  @override
  List<Object?> get props => [
        id,
        companyId,
        companyName,
        statusName,
        label,
        labelAmount,
        maturityDate, // DateTime olarak
        rateOfReturn,
        rateOfReturnDescription,
        monthlyReturnAmount,
        timeRemainingUntilReturn,
        lastPrice,
        imageUrl,
        currentEarnings,
        pendingEarnings,
        totalPendingEarnings,
        frequencyOfReturn
      ];
}

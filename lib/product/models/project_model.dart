import 'package:common/common.dart';
import 'package:misyonbank/product/models/base_model.dart';
import 'package:misyonbank/product/utils/extensions.dart';

class ProjectModel extends BaseModel {
  final String? id;
  final String? ownerName;
  final String? imageUrl;
  final String? shortDesc;
  final String? earningFrequency;
  final int? maturity;
  final double? earningRate;
  final double? rate;
  final double? completedTargetRate;
  final String? startDate;
  final List<String>? categories;
  final ProjectStatus? status;
  final InvestmentStatus? investmentStatus;
  final int? favoriteCount;
  final String? completedAmount;
  final String? monthlyPaymentCount;
  final String? accountPaymentMethod;
  final PaymentMethod? paymentMethod;
  final double? amountReceived;
  final RiskType? riskType;
  final String? backimage;

  ProjectModel({
    this.id,
    this.ownerName,
    this.imageUrl,
    this.shortDesc,
    this.startDate,
    this.earningFrequency,
    this.maturity,
    this.earningRate,
    this.rate,
    this.completedTargetRate,
    this.categories,
    this.status,
    this.investmentStatus,
    this.favoriteCount,
    this.completedAmount,
    this.amountReceived,
    this.monthlyPaymentCount,
    this.accountPaymentMethod,
    this.paymentMethod,
    this.backimage,
    this.riskType,
  });
  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json["id"],
        ownerName: json["ownerName"],
        imageUrl: json["imageUrl"],
        shortDesc: json["shortDesc"],
        earningFrequency: json["earningFrequency"],
        maturity: json["maturity"],
        earningRate: json["earningRate"]?.toDouble(),
        rate: json["rate"]?.toDouble(),
        completedTargetRate: json["completedTargetRate"]?.toDouble(),
        startDate: json["startDate"],
        backimage: json["backimage"],
        categories: json["categories"] != null
            ? List<String>.from(json["categories"])
            : null,
        status: ProjectStatusExtension.fromString(json["status"]),
        investmentStatus: InvestmentStatusExtension.fromString(
            json["investmentStatus"] ?? ''),
        favoriteCount: json["favoriteCount"],
        completedAmount: json["completedAmount"]?.toString(),
        monthlyPaymentCount: json["monthlyPaymentCount"]?.toString(),
        accountPaymentMethod: json["accountPaymentMethod"]?.toString(),
        amountReceived: json["amountReceived"]?.toDouble(),
        riskType: json["riskType"] != null
            ? RiskType.values.firstWhere(
                (e) => e.name == json["riskType"],
                orElse: () => RiskType.neutral,
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ownerName": ownerName,
        "imageUrl": imageUrl,
        "shortDesc": shortDesc,
        "earningFrequency": earningFrequency,
        "maturity": maturity,
        "earningRate": earningRate,
        "rate": rate,
        "completedTargetRate": completedTargetRate,
        "startDate": startDate,
        "categories": categories,
        "status": status?.toStringValue(),
        "favoriteCount": favoriteCount,
        "completedAmount": completedAmount,
        "amountReceived": amountReceived,
        "monthlyPaymentCount": monthlyPaymentCount,
        "accountPaymentMethod": accountPaymentMethod,
        "riskType": riskType,
        "backimage": backimage,
      };
  @override
  List<Object?> get props => [
        id,
        ownerName,
        imageUrl,
        shortDesc,
        earningFrequency,
        maturity,
        earningRate,
        rate,
        completedTargetRate,
        startDate,
        categories,
        status,
        backimage,
        favoriteCount,
        completedAmount,
        amountReceived,
        monthlyPaymentCount,
        accountPaymentMethod,
        riskType
      ];
}

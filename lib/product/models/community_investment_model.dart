import 'package:misyonbank/product/models/base_model.dart';

class CommunityInvestmentModel extends BaseModel {
  final String? id;
  final String? ownerName;
  final String? imageUrl;
  final String? investmentAmount;
  final String? investorName;
  final String? investorType;

  CommunityInvestmentModel({
    this.id,
    this.ownerName,
    this.imageUrl,
    this.investmentAmount,
    this.investorName,
    this.investorType,
  });

  factory CommunityInvestmentModel.fromJson(Map<String, dynamic> json) {
    return CommunityInvestmentModel(
      id: json['id'] as String?,
      ownerName: json['ownerName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      investmentAmount: json['investmentAmount'] as String?,
      investorName: json['investorName'] as String?,
      investorType: json['investorType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerName': ownerName,
      'imageUrl': imageUrl,
      'investmentAmount': investmentAmount,
      'investorName': investorName,
      'investorType': investorType,
    };
  }

  @override
  List<Object?> get props =>
      [id, ownerName, imageUrl, investmentAmount, investorName, investorType];
}

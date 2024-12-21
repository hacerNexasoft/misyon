import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:misyonbank/product/utils/extensions.dart';

class BankAccountModel extends Equatable {
  final String? id;
  final String? title;
  final String? imageUrl;
  final double? balance;
  final double? availableBalance;
  final BankAccountType? accountType;
  final String? currency;
  final BankAccountCategory? category;
  final String? iban;
  final String? accountHolder;

  const BankAccountModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.balance,
    required this.availableBalance,
    required this.accountType,
    required this.currency,
    required this.category,
    required this.iban,
    required this.accountHolder,
  });

  factory BankAccountModel.fromJson(Map<String, dynamic> json) => BankAccountModel(
        id: json["id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        balance: json["balance"]?.toDouble(),
        availableBalance: json["availableBalance"]?.toDouble(),
        accountType: BankAccountTypeExtension.fromString(json["accountType"]),
        currency: json["currency"],
        category: BankAccountCategoryExtension.fromString(json["category"]),
        iban: json["iban"],
        accountHolder: json["accountHolder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
        "balance": balance,
        "availableBalance": availableBalance,
        "accountType": accountType?.getStringFromEnum,
        "currency": currency,
        "category": category?.getStringFromEnum,
        "iban": iban,
        "accountHolder": accountHolder,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        balance,
        availableBalance,
        accountType,
        currency,
        category,
        iban,
        accountHolder,
      ];
}

import 'package:common/common.dart';
import 'package:equatable/equatable.dart';

class CommunityItemModel extends Equatable {
  final String? id;
  final String? projectName;
  final String? imageUrl;
  final String? ceo;
  final double? amount;
  final ExploreInvestment? investment;
  final String? minutes;
  final String? updates;
  final String? updatesSubTitle;
  final String? date;
  final List<String>? backimage;

  const CommunityItemModel({
    required this.id,
    required this.projectName,
    required this.imageUrl,
    required this.ceo,
    required this.amount,
    required this.investment,
    required this.minutes,
    this.backimage,
    required this.updates,
    required this.updatesSubTitle,
    required this.date,
  });

  factory CommunityItemModel.fromJson(Map<String, dynamic> json) =>
      CommunityItemModel(
          id: json["id"],
          backimage: json["backimage"] != null
              ? List<String>.from(json["backimage"])
              : null,
          projectName: json["projectName"] ?? "",
          imageUrl: json["imageUrl"] ?? "",
          ceo: json["projectSubtitle"] ?? "",
          amount: json["amount"] ?? "",
          investment: json["investment"] ?? "",
          minutes: json["minutes"] ?? "",
          updates: json["updates"] ?? "",
          date: json["date"] ?? "",
          updatesSubTitle: json["updatesSubTitle"] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "projectName": projectName ?? "",
        "imageUrl": imageUrl ?? "",
        "projectSubtitle": ceo ?? "",
        "amount": amount ?? "",
        "investment": investment,
        "minutes": minutes ?? "",
        "updates": updates ?? "",
        "date": date ?? "",
        "updatesSubTitle": updatesSubTitle ?? "",
      };

  @override
  List<Object?> get props => [
        id,
        projectName,
        imageUrl,
        ceo,
        amount,
        investment,
        minutes,
        updates,
        updatesSubTitle,
        date
      ];
}

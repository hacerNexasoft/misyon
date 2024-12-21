import 'package:equatable/equatable.dart';

class BankModel extends Equatable {
  final String? id;
  final String? name;
  final String? imageUrl;

  const BankModel({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
      ];
}

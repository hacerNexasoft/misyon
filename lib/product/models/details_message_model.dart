import 'package:misyonbank/product/models/base_model.dart';

class DetailsMessageModel extends BaseModel {
  final String? id;
  final List<String>? profilePicture;
  final List<String>? name;
  final List<String>? message;
  final List<String>? date;

  DetailsMessageModel(
      {this.id, this.profilePicture, this.name, this.message, this.date});

  factory DetailsMessageModel.fromJson(Map<String, dynamic> json) {
    return DetailsMessageModel(
      id: json['id'] as String,
      profilePicture: json["profilePicture"] != null
          ? List<String>.from(json["profilePicture"])
          : null,
      name: json["name"] != null ? List<String>.from(json["name"]) : null,
      message:
          json["message"] != null ? List<String>.from(json["message"]) : null,
      date: json["date"] != null ? List<String>.from(json["date"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profilePicture': profilePicture,
      'name': name,
      'message': message,
      'date': date
    };
  }

  @override
  List<Object?> get props => [id, profilePicture, name, message, date];
}

class DetailsManegerMessageModel extends BaseModel {
  final String? id;
  final String? profilePicture;
  final String? name;
  final String? message;
  final String? date;

  DetailsManegerMessageModel(
      {this.id, this.profilePicture, this.name, this.message, this.date});

  factory DetailsManegerMessageModel.fromJson(Map<String, dynamic> json) {
    return DetailsManegerMessageModel(
      id: json['id'] as String,
      profilePicture: json["profilePicture"],
      name: json["name"],
      message: json["message"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profilePicture': profilePicture,
      'name': name,
      'message': message,
      'date': date
    };
  }

  @override
  List<Object?> get props => [id, profilePicture, name, message, date];
}

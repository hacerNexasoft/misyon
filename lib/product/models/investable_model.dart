import 'package:common/common.dart';
import 'package:misyonbank/product/utils/model_helpers.dart';

class InvestableModel {
  final ProjectStatus status;
  final bool canInvestable;
  final bool renderButton;
  final String message;

  InvestableModel(
      {required this.status,
      required this.canInvestable,
      required this.renderButton,
      required this.message});

  factory InvestableModel.fromJson({required Map<String, dynamic> json}) => InvestableModel(
      status: ModelHelpers.findProjectStatusByCode(json['statusCode']),
      canInvestable: json['canInvestable'],
      renderButton: json['renderButton'],
      message: json['message']);
}

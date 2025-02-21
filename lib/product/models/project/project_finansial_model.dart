import 'package:common/common.dart';
import 'package:misyonbank/product/utils/model_helpers.dart';

class ProjectFinancialModel {
  final String id;
  final int year;
  final int financialTypeCode;
  final FinancialType finansialType;
  final List<FinancialItem> financialItems;

  ProjectFinancialModel({
    required this.id,
    required this.year,
    required this.financialTypeCode,
    required this.financialItems,
    required this.finansialType,
  });

  factory ProjectFinancialModel.fromJson(Map<String, dynamic> json) {
    return ProjectFinancialModel(
      id: json['id'],
      year: json['year'],
      finansialType: ModelHelpers.findFinancialTypeByCode(json['financialTypeCode']),
      financialTypeCode: json['financialTypeCode'],
      financialItems:
          List<FinancialItem>.from(json['financialItems'].map((x) => FinancialItem.fromJson(x))),
    );
  }
}

class FinancialItem {
  final String id;
  final ProjectFinancialId projectFinancialId;
  final ProjectFinancialDefinitionId projectFinancialDefinitionId;
  final int type;
  final String? name;
  final num value;

  FinancialItem({
    required this.id,
    required this.projectFinancialId,
    required this.projectFinancialDefinitionId,
    required this.type,
    this.name,
    required this.value,
  });

  factory FinancialItem.fromJson(Map<String, dynamic> json) {
    return FinancialItem(
      id: json['id'],
      projectFinancialId: ProjectFinancialId.fromJson(json['projectFinancialId']),
      projectFinancialDefinitionId:
          ProjectFinancialDefinitionId.fromJson(json['projectFinancialDefinitionId']),
      type: json['type'],
      name: json['name'],
      value: json['value'],
    );
  }
}

class ProjectFinancialId {
  final String key;
  final String value;

  ProjectFinancialId({required this.key, required this.value});

  factory ProjectFinancialId.fromJson(Map<String, dynamic> json) {
    return ProjectFinancialId(key: json['key'], value: json['value']);
  }
}

class ProjectFinancialDefinitionId {
  final String key;
  final String value;

  ProjectFinancialDefinitionId({required this.key, required this.value});

  factory ProjectFinancialDefinitionId.fromJson(Map<String, dynamic> json) {
    return ProjectFinancialDefinitionId(key: json['key'], value: json['value']);
  }
}

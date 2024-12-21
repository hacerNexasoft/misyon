import 'package:equatable/equatable.dart';

class PaymentTypeModel extends Equatable {
  final String title;
  final String value;

  const PaymentTypeModel({
    required this.title,
    required this.value,
  });

  @override
  List<Object?> get props => [title, value];
}
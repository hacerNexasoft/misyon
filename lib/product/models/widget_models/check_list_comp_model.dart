import 'package:equatable/equatable.dart';

class CheckListCompModel extends Equatable {
  final String title;
  bool isSelected;
  final String? imageUrl;

  CheckListCompModel({
    required this.title,
    required this.isSelected,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        title,
        isSelected,
        imageUrl,
      ];
}

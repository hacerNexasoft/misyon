import 'package:common/common.dart';
import 'package:equatable/equatable.dart';

class TimeRangeModel extends Equatable {
  final TimeRange timeRange;
  bool isSelected;

  TimeRangeModel({
    required this.timeRange,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [timeRange, isSelected];
}

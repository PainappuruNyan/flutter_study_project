import 'package:equatable/equatable.dart';


import 'time_interval.dart';

class TimeIntervalList extends Equatable{

  const TimeIntervalList({
    required this.intervals
  });
  final List<TimeInterval> intervals;

  @override
  List<Object> get props => [intervals];
}

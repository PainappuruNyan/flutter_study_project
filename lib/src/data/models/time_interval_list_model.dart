import '../../domain/entities/office_list_.dart';
import '../../domain/entities/time_interval.dart';
import '../../domain/entities/time_interval_list.dart';
import 'office_model.dart';
import 'time_interval_model.dart';

class TimeIntervalListModel extends TimeIntervalList{
  const TimeIntervalListModel({required super.intervals});


  factory TimeIntervalListModel.fromJson(List<dynamic> json) {
    final List<TimeIntervalModel> intervals = json.map((i)=>TimeIntervalModel.fromJson(i as Map<String, dynamic>)).toList();
    return TimeIntervalListModel(intervals: intervals);
  }
}

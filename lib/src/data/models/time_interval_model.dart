
import 'package:intl/intl.dart';

import '../../domain/entities/time_interval.dart';

class TimeIntervalModel extends TimeInterval{
  const TimeIntervalModel({
    required super.start,
    required super.end
  });



  factory TimeIntervalModel.fromJson(Map<String, dynamic> json){
    final DateFormat format = DateFormat('HH:mm:ss');
    return TimeIntervalModel(
        start: format.parse(json['start'] as String) ,
        end: format.parse(json['end'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'start': start,
      'end': end,
    };
  }
}

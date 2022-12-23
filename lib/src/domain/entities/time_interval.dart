import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class TimeInterval extends Equatable{
  const TimeInterval({
    required this.start,
    required this.end
  });

  final DateTime start;
  final DateTime end;

  String get startStr => DateFormat('HH:mm').format(start);

  @override
  List<Object> get props => [start, end];
}

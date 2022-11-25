import 'package:equatable/equatable.dart';

class Office extends Equatable{
  const Office({
    required this.id,
    required this.cityName,
    required this.address,
    required this.workNumber,
    required this.startOfDay,
    required this.endOfDay,
    required this.bookingRange,
});

  final int id;
  final String cityName;
  final String address;
  final String workNumber;
  final DateTime startOfDay;
  final DateTime endOfDay;
  final int bookingRange;

  @override
  List<Object> get props => [id, cityName, address, workNumber, startOfDay, endOfDay, bookingRange];
}

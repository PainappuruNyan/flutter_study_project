part of 'booking_create2_bloc.dart';

@immutable
abstract class BookingCreate2Event extends Equatable{
  const BookingCreate2Event();
}

class BookingCreate2Start extends BookingCreate2Event {
  @override
  List<Object?> get props => [];
}

class BookingCreate2DatetimeSelected extends BookingCreate2Event{

  const BookingCreate2DatetimeSelected({
    required this.date,
    required this.beginTime,
    required this.endTime,
  });

  final String date;
  final String beginTime;
  final String endTime;

  @override
  List<Object?> get props => [date, beginTime, endTime];
}


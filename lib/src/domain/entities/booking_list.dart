import 'package:equatable/equatable.dart';

import 'booking.dart';

class BookingList extends Equatable{

  const BookingList({
    required this.bookings
  });
  final List<Booking> bookings;

  @override
  List<Object> get props => [bookings];
}

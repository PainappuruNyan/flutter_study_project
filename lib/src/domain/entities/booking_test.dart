import 'package:equatable/equatable.dart';

class BookingTest extends Equatable{
  const BookingTest({
    required this.bookingId,
    required this.address,
    required this.place,
    required this.placeId,
  });

  final int bookingId;
  final String address;
  final String place;
  final int placeId;

  @override
  List<Object> get props => [bookingId];
}

class BookingListTest {

  BookingListTest({
    required this.bookingActual,
    required this.bookingHistory,
});

  final List<BookingTest> bookingActual;
  final List<BookingTest> bookingHistory;
}

import '../../domain/entities/booking_list.dart';
import 'booking_model.dart';

class BookingListModel extends BookingList {
  const BookingListModel({required super.bookings});

  factory BookingListModel.fromJson(List<dynamic> json) {
    final List<BookingModel> bookings = json
        .map((i) => BookingModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return BookingListModel(bookings: bookings);
  }
}

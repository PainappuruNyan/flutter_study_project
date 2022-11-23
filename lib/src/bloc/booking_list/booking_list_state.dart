part of 'booking_list_bloc.dart';

@immutable
abstract class BookingListState {
  const BookingListState();
}

class BookingListInitial extends BookingListState {
  const BookingListInitial();
}

class BookingListLoading extends BookingListState {
  const BookingListLoading();
}

class BookingListLoaded extends BookingListState {
  const BookingListLoaded(this.bookingList);
  final BookingListTest bookingList;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is BookingListLoaded &&
      other.bookingList == bookingList;
  }

  List<BookingTest> get bookingListHistory => bookingList.BookingHistory;
  List<BookingTest> get bookingListActual => bookingList.BookingActual;

  int get hashCodeHistory => bookingListHistory.hashCode;
  int get hashCodeActual => bookingListActual.hashCode;
  int get lengthHistory => bookingListHistory.length;
  int get lengthActual => bookingListActual.length;
}

class BookingListSelectBooking extends BookingListState {
  const BookingListSelectBooking(this.bookingSelected);
  final BookingTest bookingSelected;
}

class BookingListError extends BookingListState {
  const BookingListError(this.message);
  final String message;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is BookingListError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

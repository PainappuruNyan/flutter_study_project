part of 'booking_list_bloc.dart';

@immutable
abstract class BookingListState extends Equatable{
  const BookingListState();
}

class BookingListInitial extends BookingListState {
  const BookingListInitial();

  @override
  List<Object?> get props => [];
}

class BookingListLoading extends BookingListState {
  const BookingListLoading();

  @override
  List<Object?> get props => [];
}

class BookingListLoaded extends BookingListState {
  const BookingListLoaded({required this.bookingListActual, required this.bookingListHistory});
  final BookingList bookingListActual;
  final BookingList bookingListHistory;

  @override
  List<Object?> get props => [bookingListActual, bookingListHistory];

  int get lengthHistory => bookingListHistory.bookings.length;
  int get lengthActual => bookingListActual.bookings.length;
}

class BookingListSelectBooking extends BookingListState {
  const BookingListSelectBooking(this.bookingSelected);
  final BookingList bookingSelected;

  @override
  List<Object?> get props => [bookingSelected];
}

class BookingListError extends BookingListState {
  const BookingListError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

part of 'booking_list_bloc.dart';

@immutable
abstract class BookingListEvent {}

class GetBookingList extends BookingListEvent {

  GetBookingList();
}

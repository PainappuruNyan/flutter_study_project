part of 'booking_list_bloc.dart';

@immutable
abstract class BookingListEvent extends Equatable {
  const BookingListEvent();
}

class GetBookingList extends BookingListEvent {

  const GetBookingList();

  @override
  List<Object?> get props => [];
}

class BookingDelete extends BookingListEvent{
  const BookingDelete({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}

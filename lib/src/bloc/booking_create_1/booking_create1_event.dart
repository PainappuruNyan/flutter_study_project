part of 'booking_create1_bloc.dart';

abstract class BookingCreate1Event extends Equatable {
  const BookingCreate1Event();
}

class BookingCreate1Start extends BookingCreate1Event {
  @override
  List<Object?> get props => [];
}

class BookingCreate1FavoriteChanged extends BookingCreate1Event{

  const BookingCreate1FavoriteChanged({
    required this.id,
    required this.isFavorite
  });

  final int id;
  final bool isFavorite;

  @override
  List<Object?> get props => [id, isFavorite];
}

class BookingCreate1OfficeSelected extends BookingCreate1Event{

  const BookingCreate1OfficeSelected({
    required this.id
  });

  final int id;

  @override
  List<Object?> get props => [id];
}

part of 'booking_create1_bloc.dart';

abstract class BookingCreate1State extends Equatable {
  const BookingCreate1State();
}

class BookingCreate1Loading extends BookingCreate1State {
  @override
  List<Object> get props => [];
}

class BookingCreate1Loaded extends BookingCreate1State {

  const BookingCreate1Loaded({
    required this.offices,
    required this.cites,
    required this.favorites
  });

  final List<Office> offices;
  final List<String> cites;
  final List<Office> favorites;

  @override
  List<Object> get props => [offices, cites, favorites];
}
class BookingCreate1Error extends BookingCreate1State{

  @override
  List<Object> get props => [];
}

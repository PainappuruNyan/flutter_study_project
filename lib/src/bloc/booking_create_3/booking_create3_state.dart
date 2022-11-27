part of 'booking_create3_bloc.dart';

abstract class BookingCreate3State extends Equatable {
  const BookingCreate3State();
}

class BookingCreate3Initial extends BookingCreate3State {
  @override
  List<Object> get props => [];
}

class BookingCreate3FloorLoading extends BookingCreate3State {
  const BookingCreate3FloorLoading({required this.floorNumber, required this.floorId});


  final int floorNumber;
  final int floorId;


  @override
  List<Object?> get props => [];
}

class BookingCreate3FloorLoaded extends BookingCreate3State {
  const BookingCreate3FloorLoaded({
    required this.floors,
    required this.favorites,
    required this.usualWorkplaces,
    required this.meetengRoom
  });


  final List<int> floors;
  final List<Workplace> favorites;
  final List<Workplace> usualWorkplaces;
  final List<Workplace> meetengRoom;

  @override
  List<Object> get props => [floors, usualWorkplaces, meetengRoom];
}

class BookingCreate3FloorMapLoading extends BookingCreate3State {
  @override
  List<Object?> get props => [];
}
class BookingCreate3FloorMapLoaded extends BookingCreate3State{
  const BookingCreate3FloorMapLoaded({required this.floors});

  final List<int> floors;
  @override
  List<Object?> get props => [floors];
}
class BookingSuccess extends BookingCreate3State{
  @override
  List<Object?> get props => [];
}


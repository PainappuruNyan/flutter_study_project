part of 'booking_create3_bloc.dart';

abstract class BookingCreate3State extends Equatable {
  const BookingCreate3State();
}

class BookingCreate3Initial extends BookingCreate3State {

  @override
  List<Object> get props => [];
}

//Этажи грузятся
class BookingCreate3FloorLoading extends BookingCreate3State {
  const BookingCreate3FloorLoading(
      {required this.floorNumber, required this.officeId});

  final int floorNumber;
  final int officeId;

  @override
  List<Object?> get props => [floorNumber];
}

//Этажи успешно загрузились
class BookingCreate3FloorLoaded extends BookingCreate3State {
  BookingCreate3FloorLoaded(this.selectedFloor,
      {required this.floors,
      required this.favorites,
      required this.usualWorkplaces,
      required this.meetengRoom});

  final List<Floor> floors;
  final List<Workplace> favorites;
  final List<Workplace> usualWorkplaces;
  final List<Workplace> meetengRoom;
  int selectedFloor;

  BookingCreate3FloorLoaded copyWith({
    List<Floor>? floors,
    List<Workplace>? favorites,
    List<Workplace>? usualWorkplaces,
    List<Workplace>? meetengRoom,
    int? selectedFloor,
  }) {
    return BookingCreate3FloorLoaded(selectedFloor ?? this.selectedFloor,
        floors: floors ?? this.floors,
        favorites: favorites ?? this.favorites,
        usualWorkplaces: usualWorkplaces ?? this.usualWorkplaces,
        meetengRoom: meetengRoom ?? this.meetengRoom);
  }

  @override
  List<Object> get props =>
      [floors, usualWorkplaces, meetengRoom, selectedFloor, favorites];
}

// class BookingCreate3WorkplacesLoading extends BookingCreate3State{
//   const BookingCreate3WorkplacesLoading({
//     required this.selectedFloor
//   });
//
//   final int selectedFloor;
//
//   @override
//   List<Object?> get props => [selectedFloor];
//
// }

//Во время загрузки карты
class BookingCreate3FloorMapLoading extends BookingCreate3State {
  @override
  List<Object?> get props => [];
}

//Карты загружена
class BookingCreate3FloorMapLoaded extends BookingCreate3State {
  const BookingCreate3FloorMapLoaded({required this.floors});

  final List<Floor> floors;

  @override
  List<Object?> get props => [floors];
}

//Брони успешно создались
class BookingSuccess extends BookingCreate3State {
  @override
  List<Object?> get props => [];
}

part of 'booking_create3_bloc.dart';

abstract class BookingCreate3State extends Equatable {
  const BookingCreate3State();
}

class BookingCreate3Initial extends BookingCreate3State {
  @override
  List<Object> get props => [];
}

//загрузились этажи и люди
class ScreenInitialized extends BookingCreate3State {
  ScreenInitialized(
      {required this.selectedFloor,
      required this.floors,
      required this.bookings,
      required this.makerId,
      required this.holdersId,
      required this.holdersEmployee,
      required this.selectedEmployee});

  final int selectedFloor;
  final List<Floor> floors;
  final Map<int, BookingModel> bookings;
  final int makerId;
  final List<int> holdersId;
  final List<Employee> holdersEmployee;
  final int selectedEmployee;

  String get selectedName {
    return holdersEmployee[selectedEmployee].fullName;
  }

  int get selectedId {
    return holdersEmployee[selectedEmployee].id;
  }

  int? getSelectedPlace(int employeeId) {
    if (bookings[employeeId] != null) {
      return bookings[employeeId]?.placeId;
    }
    return -1;
  }

  @override
  List<Object?> get props => [
        floors,
        bookings,
        makerId,
        holdersId,
        holdersEmployee,
        selectedEmployee,
        selectedFloor
      ];
}

//Этажи грузятся
class BookingCreate3FloorLoading extends ScreenInitialized {
  BookingCreate3FloorLoading({
    required this.floorNumber,
    required this.officeId,
    required super.selectedFloor,
    required super.floors,
    required super.makerId,
    required super.selectedEmployee,
    required super.holdersEmployee,
    required super.holdersId,
    required super.bookings,
  });

  final int floorNumber;
  final int officeId;

  @override
  List<Object?> get props => [floorNumber];
}

//Этажи успешно загрузились
class BookingCreate3FloorLoaded extends BookingCreate3FloorLoading {
  factory BookingCreate3FloorLoaded.fromParent({
    required BookingCreate3FloorLoading parentState,
    required List<Workplace> favorites,
    required List<Workplace> usualWorkplaces,
    required List<Workplace> meetingRoom,
  }) {
    return BookingCreate3FloorLoaded(
      selectedFloor: parentState.selectedFloor,
      favorites: favorites,
      usualWorkplaces: usualWorkplaces,
      meetingRoom: meetingRoom,
      bookings: parentState.bookings,
      holdersId: parentState.holdersId,
      holdersEmployee: parentState.holdersEmployee,
      selectedEmployee: parentState.selectedEmployee,
      makerId: parentState.makerId,
      floors: parentState.floors, floorNumber: parentState.floorNumber, officeId: parentState.officeId,
    );
  }

  BookingCreate3FloorLoaded(
      {required super.selectedFloor,
      required this.favorites,
      required this.usualWorkplaces,
      required this.meetingRoom,
      required super.bookings,
      required super.holdersId,
      required super.holdersEmployee,
      required super.selectedEmployee,
      required super.makerId,
      required super.floors,
      required super.floorNumber,
      required super.officeId});

  final List<Workplace> favorites;
  final List<Workplace> usualWorkplaces;
  final List<Workplace> meetingRoom;

  BookingCreate3FloorLoaded copyWith(
      {List<Floor>? floors,
      List<Workplace>? favorites,
      List<Workplace>? usualWorkplaces,
      List<Workplace>? meetingRoom,
      int? selectedFloor,
      Map<int, BookingModel>? bookings,
      int? makerId,
      List<int>? holdersId,
      List<Employee>? holdersEmployee,
      int? selectedEmployee,
      int? floorNumber,
      int? officeId}) {
    return BookingCreate3FloorLoaded(
      selectedFloor: selectedFloor ?? this.selectedFloor,
      bookings: bookings ?? this.bookings,
      floors: floors ?? this.floors,
      favorites: favorites ?? this.favorites,
      usualWorkplaces: usualWorkplaces ?? this.usualWorkplaces,
      meetingRoom: meetingRoom ?? this.meetingRoom,
      makerId: makerId ?? this.makerId,
      holdersId: holdersId ?? this.holdersId,
      holdersEmployee: holdersEmployee ?? this.holdersEmployee,
      selectedEmployee: selectedEmployee ?? this.selectedEmployee,
      floorNumber: floorNumber ?? this.floorNumber,
      officeId: officeId ?? this.officeId,
    );
  }

  @override
  List<Object> get props => [
        floors,
        usualWorkplaces,
        meetingRoom,
        selectedFloor,
        favorites,
        bookings,
        makerId,
        holdersId,
        holdersEmployee,
        selectedEmployee
      ];
}

class BookingCreate3WorkplacesLoading extends BookingCreate3FloorLoading {
  BookingCreate3WorkplacesLoading(
      {required super.selectedFloor,
      required super.makerId,
      required super.selectedEmployee,
      required super.holdersEmployee,
      required super.holdersId,
      required super.bookings,
      required super.floors,
        required super.floorNumber,
        required super.officeId});

  factory BookingCreate3WorkplacesLoading.fromParent(
      {required BookingCreate3FloorLoading parentState, required int selectedFloor}) {
    return BookingCreate3WorkplacesLoading(
      selectedFloor: selectedFloor,
      bookings: parentState.bookings,
      holdersId: parentState.holdersId,
      holdersEmployee: parentState.holdersEmployee,
      selectedEmployee: parentState.selectedEmployee,
      makerId: parentState.makerId,
      floors: parentState.floors,
        floorNumber: parentState.floorNumber,
        officeId: parentState.officeId
    );
  }
}

class ShowWorkplaces extends BookingCreate3FloorLoaded {
  ShowWorkplaces(
      {required super.selectedFloor,
      required super.favorites,
      required super.usualWorkplaces,
      required super.meetingRoom,
      required super.bookings,
      required super.holdersId,
      required super.holdersEmployee,
      required super.selectedEmployee,
      required super.makerId,
      required super.floors,
        required super.officeId,
        required super.floorNumber,
      });
}

//Во время загрузки карты
class BookingCreate3ShowMap extends BookingCreate3FloorLoaded {
  BookingCreate3ShowMap(
      {required super.favorites,
      required super.usualWorkplaces,
      required super.meetingRoom,
      required super.selectedFloor,
      required super.makerId,
      required super.selectedEmployee,
      required super.holdersEmployee,
      required super.holdersId,
      required super.bookings,
      required super.floors,
        required super.officeId,
        required super.floorNumber,
      });

  Floor? get selectedFloorEntity {
    print(selectedFloor);
    print('Все этажи ${floors.map((Floor e) => e.floorNumber).toList()}');
    print('Мы ищем этаж $selectedFloor');
    return floors
        .firstWhere((Floor element) => element.floorNumber == selectedFloor);
  }
}

//Брони успешно создались
class BookingSuccess extends BookingCreate3State {
  @override
  List<Object?> get props => [];
}

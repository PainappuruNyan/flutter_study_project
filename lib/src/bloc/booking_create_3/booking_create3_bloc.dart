import 'dart:async';

import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../data/models/booking_model.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../../data/repositories/employee_repository_impl.dart';
import '../../data/repositories/workplace_repository_impl.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/floor.dart';
import '../../domain/entities/floor_list.dart';
import '../../domain/entities/workplace.dart';
import '../../domain/entities/workplace_list.dart';

part 'booking_create3_event.dart';

part 'booking_create3_state.dart';

int toInt(bool? val) => val! ? 1 : 0;

class BookingCreate3Bloc
    extends Bloc<BookingCreate3Event, BookingCreate3State> {
  BookingCreate3Bloc(this.officeId, this.start, this.end,
      {this.countOfBooking = 1, required this.holdersId, required this.isEdit, this.editedBookingId})
      : super(BookingCreate3Initial()) {
    on<BookingCreate3Start>(_onStart);
    on<BookingCreate3ChangeToMap>(_onChangeToMap);
    on<BookingCreate3ChangeToList>(_onChangeToList);
    on<BookingCreate3ChangeFloor>(_onChangeFloor);
    on<BookingCreate3WorkplaceSelected>(_onWorkplaceSelected);
    on<BookingCreate3SendWorkplaces>(_onSendWorkplaces);
    on<BookingCreate3FavoriteChanged>(_onFavoriteChanged);
    on<ChangeSelectedEmployee>(_onChangeSelectedEmployee);
  }

  int officeId;
  final bool isEdit;
  final int? editedBookingId;
  final WorkplaceRepositoryImpl repository = di.sl();
  final EmployeeRepositoryImpl employeeRepositoryImpl = di.sl();
  List<Floor> floors = [];
  DateTime start;
  DateTime end;
  int countOfBooking;
  Map<int, BookingModel> bookings = {};
  int makerId = 1;
  List<int> holdersId;
  List<Employee> holdersEployee = [];
  int selectedEmployee = 0;

  //Начало
  FutureOr<void> _onStart(BookingCreate3Start event,
      Emitter<BookingCreate3State> emit) async {
    emit(BookingCreate3Initial());
    await repository.getFloors(officeId).then(
            (Either<Failure, FloorList> value) =>
            value.fold((Failure l) async {
              print(l.toString());
            }, (FloorList r) async {
              print(r.floors.first.id);
              floors = r.floors;
            }));
    for (int eid in holdersId) {
      await employeeRepositoryImpl
          .getEmployeeById(eid)
          .then((Either<Failure, Employee> value) =>
          value.fold((Failure l) {
            print('Пользователи не получены');
          }, (Employee r) {
            holdersEployee.add(r);
          }));
    }
    print('Полученные пользователи: ${holdersEployee.length}');
    emit(BookingCreate3WorkplacesLoading(
        selectedFloor: floors.first.floorNumber,
        makerId: makerId,
        selectedEmployee: selectedEmployee,
        holdersEmployee: holdersEployee,
        holdersId: holdersId,
        bookings: bookings,
        floors: floors,
        floorNumber: floors.first.floorNumber,
        officeId: officeId));
    _downloadWorkplaces(floors.first);
  }

  //Начать загрузку мест на этаже
  Future<void> _downloadWorkplaces(Floor selectedFloor) async {
    //загружаем места

    List<Workplace> workplaceList = [];
    List<Workplace> meetingroomList = [];
    List<Workplace> favorites = [];
    await repository
        .getWorkplaces(selectedFloor.id!, start, end)
        .then((Either<Failure, WorkplaceList> value) =>
        value.fold((Failure l) {
          return null;
        }, (WorkplaceList r) {
          workplaceList = r.places.map((Workplace e) {
            if ((state as BookingCreate3FloorLoading)
                .bookings
                .values
                .any((element) => element.placeId == e.id)) {
              e = e.copyWith(isFree: false);
            }
            return e;
          }).toList();
          print(start.toString());
          print(end.toString());
        }));
    await repository.getMeetingRooms(selectedFloor.id!, start, end).then(
            (Either<Failure, WorkplaceList> value) =>
            value.fold((Failure l) async {
              return null;
            }, (WorkplaceList r) async {
              meetingroomList = r.places.map((Workplace e) {
                if ((state as BookingCreate3FloorLoading)
                    .bookings
                    .values
                    .any((BookingModel element) => element.placeId == e.id)) {
                  e = e.copyWith(isFree: false);
                }
                return e;
              }).toList();
            }));
    await repository.getRemoteFavorites(selectedFloor.id!, start, end).then(
            (Either<Failure, WorkplaceList> value) =>
            value.fold((Failure l) {}, (WorkplaceList r) async {
              favorites = r.places.map((Workplace e) {
                if ((state as BookingCreate3FloorLoading)
                    .bookings
                    .values
                    .any((BookingModel element) => element.placeId == e.id)) {
                  e = e.copyWith(isFree: false);
                }
                return e;
              }).toList();
            }));
    emit(BookingCreate3FloorLoaded.fromParent(
        parentState: state as BookingCreate3FloorLoading,
        favorites: favorites,
        usualWorkplaces: workplaceList,
        meetingRoom: meetingroomList));
    emit(ShowWorkplaces(
        selectedFloor: (state as BookingCreate3FloorLoaded).selectedFloor,
        favorites: (state as BookingCreate3FloorLoaded).favorites,
        usualWorkplaces: (state as BookingCreate3FloorLoaded).usualWorkplaces,
        meetingRoom: (state as BookingCreate3FloorLoaded).meetingRoom,
        bookings: (state as BookingCreate3FloorLoaded).bookings,
        holdersId: (state as BookingCreate3FloorLoaded).holdersId,
        holdersEmployee: (state as BookingCreate3FloorLoaded).holdersEmployee,
        selectedEmployee: (state as BookingCreate3FloorLoaded).selectedEmployee,
        makerId: (state as BookingCreate3FloorLoaded).makerId,
        floors: (state as BookingCreate3FloorLoaded).floors,
        officeId: (state as BookingCreate3FloorLoaded).officeId,
        floorNumber: (state as BookingCreate3FloorLoaded).floorNumber));
  }

  //Сменить места на карту
  FutureOr<void> _onChangeToMap(BookingCreate3ChangeToMap event,
      Emitter<BookingCreate3State> emit) {
    emit(BookingCreate3ShowMap(
        selectedFloor: (state as BookingCreate3FloorLoaded).selectedFloor,
        favorites: (state as BookingCreate3FloorLoaded).favorites,
        usualWorkplaces: (state as BookingCreate3FloorLoaded).usualWorkplaces,
        meetingRoom: (state as BookingCreate3FloorLoaded).meetingRoom,
        bookings: (state as BookingCreate3FloorLoaded).bookings,
        holdersId: (state as BookingCreate3FloorLoaded).holdersId,
        holdersEmployee: (state as BookingCreate3FloorLoaded).holdersEmployee,
        selectedEmployee: (state as BookingCreate3FloorLoaded).selectedEmployee,
        makerId: (state as BookingCreate3FloorLoaded).makerId,
        floors: (state as BookingCreate3FloorLoaded).floors,
        officeId: (state as BookingCreate3FloorLoaded).officeId,
        floorNumber: (state as BookingCreate3FloorLoaded).floorNumber));
  }

  //Сменить на список мест
  FutureOr<void> _onChangeToList(BookingCreate3ChangeToList event,
      Emitter<BookingCreate3State> emit) {
    emit(ShowWorkplaces(
        selectedFloor: (state as BookingCreate3FloorLoaded).selectedFloor,
        favorites: (state as BookingCreate3FloorLoaded).favorites,
        usualWorkplaces: (state as BookingCreate3FloorLoaded).usualWorkplaces,
        meetingRoom: (state as BookingCreate3FloorLoaded).meetingRoom,
        bookings: (state as BookingCreate3FloorLoaded).bookings,
        holdersId: (state as BookingCreate3FloorLoaded).holdersId,
        holdersEmployee: (state as BookingCreate3FloorLoaded).holdersEmployee,
        selectedEmployee: (state as BookingCreate3FloorLoaded).selectedEmployee,
        makerId: (state as BookingCreate3FloorLoaded).makerId,
        floors: (state as BookingCreate3FloorLoaded).floors,
        officeId: (state as BookingCreate3FloorLoaded).officeId,
        floorNumber: (state as BookingCreate3FloorLoaded).floorNumber));
  }

  //Сменить этаж
  FutureOr<void> _onChangeFloor(BookingCreate3ChangeFloor event,
      Emitter<BookingCreate3State> emit) {
    emit(BookingCreate3WorkplacesLoading.fromParent(
        selectedFloor: event.floorNumber,
        parentState: state as BookingCreate3FloorLoading));

    _downloadWorkplaces(floors.firstWhere(
            (Floor element) => element.floorNumber == event.floorNumber));
  }

  //Выбрать место
  Future<void> _onWorkplaceSelected(BookingCreate3WorkplaceSelected event,
      Emitter<BookingCreate3State> emit) async {
    print('adding booking');
    Map<int, BookingModel> nBooking = Map<int, BookingModel>.of(
        (state as BookingCreate3FloorLoaded).bookings);
    nBooking[event.employeeId] = event.booking;
    List<Workplace> nworkplaces = List<Workplace>.of(
        (state as BookingCreate3FloorLoaded).usualWorkplaces.map((Workplace e) {
          if (nBooking.values
              .any((BookingModel element) => element.placeId == e.id)) {
            e = e.copyWith(isFree: false);
          }
          return e;
        })).toList();
    List<Workplace> nmeetingrooms = List<Workplace>.of(
        (state as BookingCreate3FloorLoaded).meetingRoom.map((Workplace e) {
          if (nBooking.values
              .any((BookingModel element) => element.placeId == e.id)) {
            e = e.copyWith(isFree: false);
          }
          return e;
        })).toList();
    List<Workplace> nfavorites = List<Workplace>.of(
        (state as BookingCreate3FloorLoaded).favorites.map((Workplace e) {
          if (nBooking.values
              .any((BookingModel element) => element.placeId == e.id)) {
            e = e.copyWith(isFree: false);
          }
          return e;
        })).toList();
    // emit((state as BookingCreate3FloorLoaded).copyWith(
    //     bookings: nBooking,
    //     usualWorkplaces: nworkplaces,
    //     meetingRoom: nmeetingrooms,
    //     favorites: nfavorites));
    emit(ShowWorkplaces(
        selectedFloor: (state as BookingCreate3FloorLoaded).selectedFloor,
        favorites: nfavorites,
        usualWorkplaces: nworkplaces,
        meetingRoom: nmeetingrooms,
        bookings: nBooking,
        holdersId: (state as BookingCreate3FloorLoaded).holdersId,
        holdersEmployee: (state as BookingCreate3FloorLoaded).holdersEmployee,
        selectedEmployee: (state as BookingCreate3FloorLoaded).selectedEmployee,
        makerId: (state as BookingCreate3FloorLoaded).makerId,
        floors: (state as BookingCreate3FloorLoaded).floors,
        officeId: (state as BookingCreate3FloorLoaded).officeId,
        floorNumber: (state as BookingCreate3FloorLoaded).floorNumber));

    _downloadWorkplaces(floors.firstWhere((Floor element) =>
    element.floorNumber ==
        (state as BookingCreate3FloorLoaded).selectedFloor));

    print(bookings);
  }

  Future<void> _onSendWorkplaces(BookingCreate3SendWorkplaces event,
      Emitter<BookingCreate3State> emit) async {
    print(isEdit);
    print(editedBookingId);
    print('start sending');

    final BookingRepositoryImpl bookingRepositoryImpl = di.sl();
    if (isEdit == false) {
      for (BookingModel b
      in (state as BookingCreate3FloorLoaded).bookings.values) {
        await bookingRepositoryImpl
            .postBooking(booking: b)
            .then((Either<Failure, String> value) {
          value.fold((Failure l) => print(l.toString()), (String r) async {});
        });
      }
      emit(BookingSuccess());
    }
    else {
      for (BookingModel b
      in (state as BookingCreate3FloorLoaded).bookings.values) {
        await bookingRepositoryImpl
            .editBooking(booking: b.copyWithId(id: editedBookingId))
            .then((Either<Failure, String> value) {
          value.fold((Failure l) => print(l.toString()), (String r) async {});
        });
      }
      emit(BookingSuccess());
    }
  }

  Future<void> _onFavoriteChanged(BookingCreate3FavoriteChanged event,
      Emitter<BookingCreate3State> emit) async {
    print('меняем избранное');
    await repository.changeRemoteFavorites(event.workplaceId, event.isFavorite);
    _downloadWorkplaces(floors.firstWhere((Floor element) =>
    element.floorNumber ==
        (state as BookingCreate3FloorLoaded).selectedFloor));
  }

  FutureOr<void> _onChangeSelectedEmployee(ChangeSelectedEmployee event,
      Emitter<BookingCreate3State> emit) {
    emit((state as BookingCreate3FloorLoaded)
        .copyWith(selectedEmployee: event.nSelectedId));
    emit(ShowWorkplaces(
        selectedFloor: (state as BookingCreate3FloorLoaded).selectedFloor,
        favorites: (state as BookingCreate3FloorLoaded).favorites,
        usualWorkplaces: (state as BookingCreate3FloorLoaded).usualWorkplaces,
        meetingRoom: (state as BookingCreate3FloorLoaded).meetingRoom,
        bookings: (state as BookingCreate3FloorLoaded).bookings,
        holdersId: (state as BookingCreate3FloorLoaded).holdersId,
        holdersEmployee: (state as BookingCreate3FloorLoaded).holdersEmployee,
        selectedEmployee: (state as BookingCreate3FloorLoaded).selectedEmployee,
        makerId: (state as BookingCreate3FloorLoaded).makerId,
        floors: (state as BookingCreate3FloorLoaded).floors,
        officeId: (state as BookingCreate3FloorLoaded).officeId,
        floorNumber: (state as BookingCreate3FloorLoaded).floorNumber));
  }

}

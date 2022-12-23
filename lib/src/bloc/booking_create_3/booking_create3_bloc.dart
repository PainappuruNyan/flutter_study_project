import 'dart:async';

import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../data/models/booking_model.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../../data/repositories/workplace_repository_impl.dart';
import '../../domain/entities/booking.dart';
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
      {this.countOfBooking = 1})
      : super(BookingCreate3Initial()) {
    on<BookingCreate3Start>(_onStart);
    on<BookingCreate3ChangeToMap>(_onChangeToMap);
    on<BookingCreate3ChangeToList>(_onChangeToList);
    on<BookingCreate3ChangeFloor>(_onChangeFloor);
    on<BookingCreate3WorkplaceSelected>(_onWorkplaceSelected);
    on<BookingCreate3SendWorkplaces>(_onSendWorkplaces);
    on<BookingCreate3FavoriteChanged>(_onFavoriteChanged);
  }

  int officeId;
  final WorkplaceRepositoryImpl repository = di.sl();
  List<Floor> floors = [];
  DateTime start;
  DateTime end;
  int countOfBooking;
  List<BookingModel> bookings = [];
  int makerId = 1;
  List<int> holdersId = [1];

  //Начало
  FutureOr<void> _onStart(
      BookingCreate3Start event, Emitter<BookingCreate3State> emit) async {
    emit(BookingCreate3Initial());

    await repository.getFloors(officeId).then(
        (Either<Failure, FloorList> value) => value.fold((Failure l) async {
              print(l.toString());
            }, (FloorList r) async {
              print(r.floors.first.id);
              floors = r.floors;
            }));

    _downloadWorkplaces(floors.first);
  }

  //Начать загрузку мест на этаже
  Future<void> _downloadWorkplaces(Floor selectedFloor) async {
    //загружаем места

    List<Workplace> workplaceList = [];
    List<Workplace> meetingroomList = [];
    List<Workplace> favorites = [];
    await repository
        .getWorkplaces(selectedFloor.id, start, end)
        .then((Either<Failure, WorkplaceList> value) => value.fold((Failure l) {
              return null;
            }, (WorkplaceList r) {
              workplaceList = r.places;
              print(start.toString());
              print(end.toString());
            }));
    await repository.getMeetingRooms(selectedFloor.id, start, end).then(
        (Either<Failure, WorkplaceList> value) => value.fold((Failure l) async {
              return null;
            }, (WorkplaceList r) async {
              meetingroomList = r.places;
            }));
    await repository.getRemoteFavorites(selectedFloor.id, start, end).then(
        (Either<Failure, WorkplaceList> value) =>
            value.fold((Failure l) {}, (WorkplaceList r) async {
              favorites = r.places;
            }));
    emit(BookingCreate3FloorLoaded(
        floors: floors,
        favorites: favorites,
        usualWorkplaces: workplaceList,
        meetengRoom: meetingroomList,
        selectedFloor.floorNumber));
  }

  //Сменить места на карту
  FutureOr<void> _onChangeToMap(
      BookingCreate3ChangeToMap event, Emitter<BookingCreate3State> emit) {
    emit(BookingCreate3FloorMapLoaded(floors: floors));
  }

  //Сменить на список мест
  FutureOr<void> _onChangeToList(
      BookingCreate3ChangeToList event, Emitter<BookingCreate3State> emit) {
    add(BookingCreate3Start());
  }

  //Сменить этаж
  FutureOr<void> _onChangeFloor(
      BookingCreate3ChangeFloor event, Emitter<BookingCreate3State> emit) {
    emit(BookingCreate3FloorLoading(
        floorNumber: event.floorNumber, officeId: officeId));
    _downloadWorkplaces(floors.firstWhere(
        (Floor element) => element.floorNumber == event.floorNumber));
  }

  //Выбрать место
  Future<void> _onWorkplaceSelected(BookingCreate3WorkplaceSelected event,
      Emitter<BookingCreate3State> emit) async {
    print('adding booking');
    bookings.add(event.booking);
    print(bookings);
  }

  Future<void> _onSendWorkplaces(BookingCreate3SendWorkplaces event,
      Emitter<BookingCreate3State> emit) async {
    print('start sending');
    final BookingRepositoryImpl bookingRepositoryImpl = di.sl();
    for (BookingModel b in bookings) {
      await bookingRepositoryImpl
          .postBooking(booking: b)
          .then((Either<Failure, String> value) {
        value.fold((Failure l) => print(l.toString()), (String r) async {});
      });
    }
    emit(BookingSuccess());
  }

  Future<void> _onFavoriteChanged(BookingCreate3FavoriteChanged event,
      Emitter<BookingCreate3State> emit) async {
    print('меняем избранное');
    await repository.changeRemoteFavorites(event.workplaceId, event.isFavorite);
    _downloadWorkplaces(floors.firstWhere((Floor element) =>
          element.floorNumber ==
          (state as BookingCreate3FloorLoaded).selectedFloor));
  }
}

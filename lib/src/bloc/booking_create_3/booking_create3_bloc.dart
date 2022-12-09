import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../data/models/booking_model.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../../data/repositories/workplace_repository_impl.dart';
import '../../domain/entities/floor.dart';
import '../../domain/entities/floor_list.dart';
import '../../domain/entities/workplace.dart';
import 'package:atb_first_project/dependency_injection_container.dart' as di;

part 'booking_create3_event.dart';

part 'booking_create3_state.dart';

int toInt(bool? val) => val! ? 1 : 0;

class BookingCreate3Bloc
    extends Bloc<BookingCreate3Event, BookingCreate3State> {

  BookingCreate3Bloc(this.officeId) : super(BookingCreate3Initial()) {
    on<BookingCreate3Start>(_onStart);
    on<BookingCreate3ChangeToMap>(_onChangeToMap);
    on<BookingCreate3ChangeToList>(_onChangeToList);
    on<BookingCreate3ChangeFloor>(_onChangeFloor);
    on<BookingCreate3WorkplaceSelected>(_onWorkplaceSelected);
  }

  int officeId;
  final WorkplaceRepositoryImpl repository = di.sl();
  List<Floor> floors = [];

  FutureOr<void> _onStart(
      BookingCreate3Start event, Emitter<BookingCreate3State> emit) async {
    emit(BookingCreate3Initial());
    await repository.getFloors(officeId).then((Either<Failure, FloorList> value)
    => value.fold(
            (Failure l) async {
            },
            (FloorList r) async {
              floors = r.floors;
            }));

    _downloadWorkplaces(floors.first.floorNumber);
  }

  Future<void> _downloadWorkplaces(int selectedFloor) async {
    //загружаем места
    final List<Workplace> favoriteList = [
      const Workplace(true, id: 1, typeName: '1', floorId: 1, capacity: 1),
      const Workplace(false, id: 3, typeName: '1', floorId: 3, capacity: 1),
      const Workplace(true, id: 4, typeName: '1', floorId: 1, capacity: 1),
      const Workplace(false, id: 5, typeName: '1', floorId: 2, capacity: 1),
    ];
    favoriteList.sort((Workplace a, Workplace b) =>
        toInt(a.isFree).compareTo(toInt(b.isFree)));
    final List<Workplace> workplaceList = [
      const Workplace(true, id: 2, typeName: '1', floorId: 1, capacity: 1),
      const Workplace(false, id: 6, typeName: '1', floorId: 3, capacity: 1),
      const Workplace(true, id: 7, typeName: '1', floorId: 1, capacity: 1),
      const Workplace(true, id: 8, typeName: '1', floorId: 2, capacity: 1),
    ];
    workplaceList.sort((Workplace a, Workplace b) =>
        toInt(a.isFree).compareTo(toInt(b.isFree)));
    final List<Workplace> meetingroomList = [
      const Workplace(true, id: 9, typeName: '2', floorId: 1, capacity: 6),
      const Workplace(false, id: 10, typeName: '2', floorId: 3, capacity: 4),
      const Workplace(false, id: 11, typeName: '2', floorId: 1, capacity: 4),
      const Workplace(true, id: 12, typeName: '2', floorId: 2, capacity: 8),
    ];
    meetingroomList.sort((Workplace a, Workplace b) =>
        toInt(a.isFree).compareTo(toInt(b.isFree)));
    emit(BookingCreate3FloorLoaded(
        floors: floors,
        favorites: favoriteList,
        usualWorkplaces: workplaceList,
        meetengRoom: meetingroomList,
        selectedFloor
    ));
  }

  FutureOr<void> _onChangeToMap(
      BookingCreate3ChangeToMap event, Emitter<BookingCreate3State> emit) {
    emit(BookingCreate3FloorMapLoaded(floors: floors));
  }

  FutureOr<void> _onChangeToList(
      BookingCreate3ChangeToList event, Emitter<BookingCreate3State> emit) {
    add(BookingCreate3Start());
  }

  FutureOr<void> _onChangeFloor(
      BookingCreate3ChangeFloor event, Emitter<BookingCreate3State> emit) {
    emit(BookingCreate3FloorLoading(floorNumber: event.floorNumber, officeId: officeId));
    _downloadWorkplaces(event.floorNumber);
  }

  Future<void> _onWorkplaceSelected(BookingCreate3WorkplaceSelected event,
      Emitter<BookingCreate3State> emit) async {
    print('starting');
    final BookingRepositoryImpl bookingRepositoryImpl = di.sl();

    await bookingRepositoryImpl
        .postBooking(booking: event.booking)
        .then((Either<Failure, String> value) {
      value.fold((Failure l) => print(l.toString()), (String r) async {
        emit(BookingSuccess());
      });
    });
  }
}

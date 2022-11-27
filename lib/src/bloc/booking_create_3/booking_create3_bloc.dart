import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../data/models/booking_model.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../../domain/entities/workplace.dart';
import 'package:atb_first_project/dependency_injection_container.dart' as di;

part 'booking_create3_event.dart';

part 'booking_create3_state.dart';

class BookingCreate3Bloc
    extends Bloc<BookingCreate3Event, BookingCreate3State> {
  BookingCreate3Bloc() : super(BookingCreate3Initial()) {
    on<BookingCreate3Start>(_onStart);
    on<BookingCreate3ChangeToMap>(_onChangeToMap);
    on<BookingCreate3ChangeToList>(_onChangeToList);
    on<BookingCreate3ChangeFloor>(_onChangeFloor);
    on<BookingCreate3WorkplaceSelected>(_onWorkplaceSelected);
  }

  FutureOr<void> _onStart(
      BookingCreate3Start event, Emitter<BookingCreate3State> emit) async {
    emit(BookingCreate3Initial());
    final List<int> floors = [
      1,
      2,
      3,
      4,
    ];
    final List<Workplace> favoriteList = [
      const Workplace(true, id: 1, type_id: 1, floor_id: 1, capacity: 1),
      const Workplace(false, id: 3, type_id: 1, floor_id: 3, capacity: 1),
      const Workplace(true, id: 4, type_id: 1, floor_id: 1, capacity: 1),
      const Workplace(false, id: 5, type_id: 1, floor_id: 2, capacity: 1),
    ];
    final List<Workplace> workplaceList = [
      const Workplace(true, id: 2, type_id: 1, floor_id: 1, capacity: 1),
      const Workplace(false, id: 6, type_id: 1, floor_id: 3, capacity: 1),
      const Workplace(true, id: 7, type_id: 1, floor_id: 1, capacity: 1),
      const Workplace(true, id: 8, type_id: 1, floor_id: 2, capacity: 1),
    ];
    final List<Workplace> meetingroomList = [
      const Workplace(true, id: 9, type_id: 1, floor_id: 1, capacity: 6),
      const Workplace(false, id: 10, type_id: 1, floor_id: 3, capacity: 4),
      const Workplace(false, id: 11, type_id: 1, floor_id: 1, capacity: 4),
      const Workplace(true, id: 12, type_id: 1, floor_id: 2, capacity: 8),
    ];
    emit(BookingCreate3FloorLoaded(floors: floors,favorites: favoriteList, usualWorkplaces: workplaceList, meetengRoom: meetingroomList));
  }

  FutureOr<void> _onChangeToMap(
      BookingCreate3ChangeToMap event, Emitter<BookingCreate3State> emit) {}

  FutureOr<void> _onChangeToList(
      BookingCreate3ChangeToList event, Emitter<BookingCreate3State> emit) {}

  FutureOr<void> _onChangeFloor(
      BookingCreate3ChangeFloor event, Emitter<BookingCreate3State> emit) {}

  Future<void> _onWorkplaceSelected(BookingCreate3WorkplaceSelected event,
      Emitter<BookingCreate3State> emit) async {
    print('starting');
    final BookingRepositoryImpl bookingRepositoryImpl = di.sl();

    await bookingRepositoryImpl
        .postBooking(booking: event.booking)
        .then((Either<Failure, String> value) {
      value.fold((Failure l) => print(l.toString()), (String r) async {
        print('Успех');
      });
    });
  }
}

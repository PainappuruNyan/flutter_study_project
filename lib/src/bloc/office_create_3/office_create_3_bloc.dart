import 'dart:async';

import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../data/repositories/workplace_repository_impl.dart';
import '../../domain/entities/floor.dart';
import '../../domain/entities/floor_list.dart';
import '../office_create_2/office_create_2_bloc.dart';

part 'office_create_3_event.dart';
part 'office_create_3_state.dart';

class OfficeCreate3Bloc extends Bloc<OfficeCreate3Event, OfficeCreate3State> {
  OfficeCreate3Bloc(this.officeId)
      : super(OfficeCreate3Initial(officeId: officeId)) {
    on<LoadScreen>(_loadScreen);
    on<FloorSelected>(_floorSelected);
    on<LoadMap>(_loadMap);
  }

  final int officeId;
  WorkplaceRepositoryImpl repositoryImpl = di.sl();

  Future<void> _loadScreen(LoadScreen event,
      Emitter<OfficeCreate3State> emit) async {
    List<Floor> floors = await repositoryImpl
        .getFloors(officeId)
        .then((Either<Failure, FloorList> value) =>
        value.fold((Failure l) {
          print('получение этажей прошло с ошибкой');
          emit(const ErrorState(message: 'получение этажей прошло с ошибкой'));
          return [];
        }, (FloorList r) => r.floors));
    if(state is! ErrorState){
      await repositoryImpl.getMiniFloors(floors).then((Either<Failure, List<MiniFloor>> value) =>
          value.fold(
                  (Failure l){
                    emit(const ErrorState(message: 'Получение мест прошло с ошибкой'));
              },
                  (List<MiniFloor> r) {
                    emit(ScreenLoaded(floors: r));
              }));
    }

  }

  FutureOr<void> _floorSelected(FloorSelected event,
      Emitter<OfficeCreate3State> emit) {}

  Future<void> _loadMap(LoadMap event,
      Emitter<OfficeCreate3State> emit) async {}
}

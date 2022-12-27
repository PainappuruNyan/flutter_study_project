import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../data/models/workplase_model.dart';
import '../../data/repositories/workplace_repository_impl.dart';
import '../../domain/entities/floor.dart';
import '../../domain/entities/workplace.dart';
import 'package:atb_first_project/dependency_injection_container.dart' as di;

import '../../domain/entities/workplace_list.dart';

part 'edit_floor_event.dart';

part 'edit_floor_state.dart';

class EditFloorBloc extends Bloc<EditFloorEvent, EditFloorState> {
  EditFloorBloc({required this.floorId, required this.workplaceType})
      : super(EditFloorInitial()) {
    on<EditFloorStart>(_onStart);
    on<EditFloorPlaceChanged>(_onPlaceChange);
    on<EditFloorPlaceCreate>(_onCreate);
    on<EditFloorPlaceDelete>(_onDelete);
    // on<EditFloorConfirm>();
  }

  final int floorId;
  final int workplaceType;

  WorkplaceRepositoryImpl repositoryImpl = di.sl();

  FutureOr<void> _onStart(
      EditFloorStart event, Emitter<EditFloorState> emit) async {
    Floor? nFloor;
    await repositoryImpl.getFloor(floorId).then(
        (Either<Failure, Floor> value) => value.fold((Failure l) {}, (Floor r) {
              nFloor = r;
            }));
    if (nFloor != null) {
      await repositoryImpl
          .getWorkplacesByFloor(event.floorId, event.workplaceType)
          .then((Either<Failure, WorkplaceList> value) =>
              value.fold((Failure l) {}, (WorkplaceList r) {
                print(r.places);
                emit(EditFloorLoaded(
                    floorId: floorId,
                    workplaceType: workplaceType,
                    places: r.places,
                    floor: nFloor!));
              }));
    }
  }

  FutureOr<void> _onPlaceChange(
      EditFloorPlaceChanged event, Emitter<EditFloorState> emit) async {
    await repositoryImpl
        .updateWorkplace(WorkplaceModel(
            id: event.workplaceId,
            isFree: null,
            capacity: event.nCapacity,
            floorId: floorId,
            typeName: '',
            typeId: workplaceType, placeName: event.nName))
        .then((Either<Failure, String> value) =>
            value.fold((Failure l) {}, (String r) {
              final List<Workplace> nPlaces =
                  List.of((state as EditFloorLoaded).places.map((Workplace e) {
                    Workplace temp = Workplace(id: e.id,
                      typeName: e.typeName,
                      floorId: e.floorId,
                      capacity: e.capacity,
                      typeId: e.typeId,
                      isFree: e.isFree,
                      placeName: e.placeName);
                    if (e.id == event.workplaceId) {
                      temp.capacity = event.nCapacity;
                      temp.placeName = event.nName;
                    }
                    return temp;
                  }).toList());
              emit((state as EditFloorLoaded).copyWith(places: nPlaces));
            }));
  }

  FutureOr<void> _onCreate(
      EditFloorPlaceCreate event, Emitter<EditFloorState> emit) async {
    await repositoryImpl
        .postWorkplace(WorkplaceModel(
            id: null,
            isFree: null,
            capacity: workplaceType,
            floorId: floorId,
            typeName: '',
            typeId: workplaceType, placeName: null))
        .then((Either<Failure, String> value) => value.fold(
            (Failure l) {},
            (String r) {
              add(EditFloorStart(floorId: floorId, workplaceType: workplaceType));
            }));
  }

  FutureOr<void> _onDelete(
      EditFloorPlaceDelete event, Emitter<EditFloorState> emit) async {
    await repositoryImpl.deleteWorkplace(event.workplaceId).then(
        (Either<Failure, String> value) =>
            value.fold((Failure l) {}, (String r) {
              final List<Workplace> nPlaces =
                  List.from((state as EditFloorLoaded).places)
                    ..removeWhere(
                        (Workplace element) => element.id == event.workplaceId);
              emit((state as EditFloorLoaded).copyWith(places: nPlaces));
            }));
  }
}

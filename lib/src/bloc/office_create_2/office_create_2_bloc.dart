import 'dart:async';

import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../data/repositories/administration_repository_impl.dart';
import '../../domain/entities/workplace.dart';

part 'office_create_2_event.dart';
part 'office_create_2_state.dart';

class MiniWorkplace {
  MiniWorkplace({this.capacity = 1, required this.typeId});

  factory MiniWorkplace.fromEntity(Workplace model, int typeId){
    return MiniWorkplace(typeId: typeId, capacity: model.capacity );
  }

  int typeId;
  int capacity;
}

class MiniFloor {
  MiniFloor({required this.floorNumber, required this.officeId, this.floorId});

  int? floorId;
  int floorNumber;
  int officeId;
  List<MiniWorkplace> meetingRooms = [];
  List<MiniWorkplace> workplaces = [];
  int workplaceCount = 0;
  int meetingRoomCount = 0;
  set nMeetingRooms(List<MiniWorkplace> places) {
    meetingRooms = places;
    meetingRoomCount = places.length;
  }
  set nWorkplaces(List<MiniWorkplace> places) {
    workplaces = places;
    workplaceCount = places.length;
  }


  void setWorkplaces() {
    meetingRooms = List<MiniWorkplace>.generate(meetingRoomCount, (int index) {
      return MiniWorkplace(capacity: 2, typeId: 2);
    });
    workplaces = List<MiniWorkplace>.generate(workplaceCount, (int index) {
      return MiniWorkplace(typeId: 1);
    });
  }



  static MiniFloor copy(MiniFloor floor) {
    return floor;
  }
}

class OfficeCreate2Bloc extends Bloc<OfficeCreate2Event, OfficeCreate2State> {
  OfficeCreate2Bloc({required this.officeId}) : super(OfficeCreate2Initial()) {
    on<OfficeCreate2Start>(_onStart);
    on<EnterFloorCount>(_onEnterFloorCount);
    on<ChangeOneFloor>(_onChangeOneFloor);
    on<ConfirmCreation>(_onConfirm);
  }

  int officeId;
  AdministrationRepositoryImpl repositoryImpl = di.sl();

  FutureOr<void> _onStart(
      OfficeCreate2Start event, Emitter<OfficeCreate2State> emit) {}

  FutureOr<void> _onEnterFloorCount(
      EnterFloorCount event, Emitter<OfficeCreate2State> emit) {
    final List<MiniFloor> floorList =
        List<MiniFloor>.generate(event.floorCount, (int index) {
      return MiniFloor(floorNumber: index + 1, officeId: officeId);
    });
    emit(FloorEntered(floorCount: event.floorCount, floorList: floorList));
  }

  FutureOr<void> _onChangeOneFloor(
      ChangeOneFloor event, Emitter<OfficeCreate2State> emit) {
    final List<MiniFloor> newFloor =
        List.from((state as FloorEntered).floorList);
    newFloor[event.floorIndex] = event.floorInstance;
    emit((state as FloorEntered).copyWith(floorList: newFloor));
  }

  FutureOr<void> _onConfirm(
      ConfirmCreation event, Emitter<OfficeCreate2State> emit) async {
    if (state is FloorEntered) {
      await repositoryImpl.postFloors((state as FloorEntered).floorList).then(
          (Either<Failure, String> value) =>
              value.fold((Failure l) {}, (String r) {
                print(r);
                emit(FloorsLoaded(
                    floorCount: (state as FloorEntered).floorCount,
                    floorList: (state as FloorEntered).floorList));
              }));
    }
  }
}

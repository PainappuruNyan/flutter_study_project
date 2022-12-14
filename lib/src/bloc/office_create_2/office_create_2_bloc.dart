import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'office_create_2_event.dart';
part 'office_create_2_state.dart';

class MiniWorkplace {
  MiniWorkplace({this.capacity = 1});

  int capacity;
}

class MiniFloor {

  MiniFloor({required this.floorNumber});

  int floorNumber;
  List<MiniWorkplace> meetingRooms = [];
  List<MiniWorkplace> workplaces = [];
  int workplaceCount = 0;
  int meetingRoomCount = 0;

  void setWorkplaces() {
    meetingRooms = List<MiniWorkplace>.generate(meetingRoomCount, (int index) {
      return MiniWorkplace(capacity: 2);
    });
    workplaces = List<MiniWorkplace>.generate(workplaceCount, (int index) {
      return MiniWorkplace();
    });
  }

  static MiniFloor copy(MiniFloor floor){
    return floor;
  }

}

class OfficeCreate2Bloc extends Bloc<OfficeCreate2Event, OfficeCreate2State> {
  OfficeCreate2Bloc() : super(OfficeCreate2Initial()) {
    on<OfficeCreate2Start>(_onStart);
    on<EnterFloorCount>(_onEnterFloorCount);
    on<ChangeOneFloor>(_onChangeOneFloor);
  }



  FutureOr<void> _onStart(OfficeCreate2Start event, Emitter<OfficeCreate2State> emit) {
  }


  FutureOr<void> _onEnterFloorCount(EnterFloorCount event, Emitter<OfficeCreate2State> emit) {
    final List<MiniFloor> floorList = List<MiniFloor>.generate(event.floorCount, (int index) {
      return MiniFloor(floorNumber: index+1);
    });
    emit(FloorEntered(floorCount: event.floorCount, floorList: floorList));
  }

  FutureOr<void> _onChangeOneFloor(ChangeOneFloor event, Emitter<OfficeCreate2State> emit){
    final List<MiniFloor> newFloor = List.from((state as FloorEntered).floorList);
    newFloor[event.floorIndex] = event.floorInstance;
    emit((state as FloorEntered).copyWith(floorList: newFloor));
  }
}

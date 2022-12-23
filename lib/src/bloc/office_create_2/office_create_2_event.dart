part of 'office_create_2_bloc.dart';

abstract class OfficeCreate2Event extends Equatable {
  const OfficeCreate2Event();

  @override
  List<Object> get props => [];
}

class OfficeCreate2Start extends OfficeCreate2Event{}

class EnterFloorCount extends OfficeCreate2Event{
  const EnterFloorCount({required this.floorCount});
  final int floorCount;

  @override
  List<Object> get props => [floorCount];
}

class ChangeOneFloor extends OfficeCreate2Event{
  const ChangeOneFloor({required this.floorIndex , required this.floorInstance} );


  final int floorIndex;
  final MiniFloor floorInstance;

  @override
  List<Object> get props => [floorIndex, floorInstance];
}

class SaveFloor extends OfficeCreate2Event{}

class ConfirmCreation extends OfficeCreate2Event{}

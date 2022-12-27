part of 'edit_floor_bloc.dart';

abstract class EditFloorEvent extends Equatable {
  const EditFloorEvent();

  @override
  List<Object?> get props => [];
}

class EditFloorStart extends EditFloorEvent {
  EditFloorStart({required this.floorId, required this.workplaceType});

  final int floorId;
  final int workplaceType;

  @override
  List<Object> get props => [floorId, workplaceType];
}

class EditFloorPlaceChanged extends EditFloorEvent {
  EditFloorPlaceChanged({required this.workplaceId, required this.nCapacity, required this.nName});

  final int workplaceId;
  final int nCapacity;
  final String? nName;

  @override
  List<Object?> get props => [workplaceId, nCapacity, nName];
}

class EditFloorPlaceCreate extends EditFloorEvent {
  EditFloorPlaceCreate({required this.floorId, required this.capacity});

  final int floorId;
  final int capacity;

  @override
  List<Object> get props => [floorId, capacity];
}

class EditFloorPlaceDelete extends EditFloorEvent {
  EditFloorPlaceDelete({required this.workplaceId});

  final int workplaceId;

  @override
  List<Object> get props => [workplaceId];
}

class EditFloorConfirm extends EditFloorEvent {}

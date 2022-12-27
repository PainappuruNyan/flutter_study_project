part of 'edit_floor_bloc.dart';

abstract class EditFloorState extends Equatable {
  const EditFloorState();

  @override
  List<Object> get props => [];
}

class EditFloorInitial extends EditFloorState {}

class EditFloorLoading extends EditFloorState {
  EditFloorLoading({required this.floorId, required this.workplaceType});

  final int floorId;
  final int workplaceType;

  @override
  List<Object> get props => [floorId, workplaceType];
}

class EditFloorLoaded extends EditFloorLoading {
  EditFloorLoaded(
      {required super.floorId,
      required super.workplaceType,
      required this.places,
      required this.floor});

  final List<Workplace> places;
  final Floor floor;

  EditFloorLoaded copyWith(
      {int? floorId,
      int? workplaceType,
      List<Workplace>? places,
      Floor? floor}) {
    return EditFloorLoaded(
        floorId: floorId ?? this.floorId,
        workplaceType: workplaceType ?? this.workplaceType,
        places: places ?? this.places,
        floor: floor ?? this.floor);
  }

  @override
  List<Object> get props => [floorId, places, floor, workplaceType];
}

class EditFloorFinished extends EditFloorState {}

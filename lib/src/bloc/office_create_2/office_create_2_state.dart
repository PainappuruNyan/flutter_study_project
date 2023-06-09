part of 'office_create_2_bloc.dart';

abstract class OfficeCreate2State extends Equatable {
  const OfficeCreate2State();
}



class OfficeCreate2Initial extends OfficeCreate2State {
  @override
  List<Object> get props => [];
}


class FloorEntered extends OfficeCreate2State {
  const FloorEntered({required this.floorCount, required this.floorList});

  final int floorCount;
  final List<MiniFloor> floorList;

  FloorEntered copyWith({
    int? floorCount,
    List<MiniFloor>? floorList,
}){
    return FloorEntered(
      floorCount: floorCount ?? this.floorCount,
      floorList: floorList ?? this.floorList
    );
  }

  @override
  List<Object?> get props => [floorCount, floorList];
}

class FloorsLoaded extends FloorEntered{
  FloorsLoaded({required super.floorCount, required super.floorList});
}

class Error extends OfficeCreate2State{
  const Error({required this.message});

  final String message;

  @override
  List<Object?> get props => [];
}
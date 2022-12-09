import 'package:equatable/equatable.dart';

import 'floor.dart';

class FloorList extends Equatable{

  const FloorList({
    required this.floors
  });
  final List<Floor> floors;

  @override
  List<Object> get props => [floors];
}

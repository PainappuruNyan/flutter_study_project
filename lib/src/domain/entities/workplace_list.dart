import 'package:equatable/equatable.dart';

import 'workplace.dart';

class WorkplaceList extends Equatable{

  const WorkplaceList({
    required this.floors
  });
  final List<Workplace> floors;

  @override
  List<Object> get props => [floors];
}

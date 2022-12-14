import 'package:equatable/equatable.dart';

import 'workplace.dart';

class WorkplaceList extends Equatable{

  const WorkplaceList({
    required this.places
  });
  final List<Workplace> places;

  @override
  List<Object> get props => [places];
}

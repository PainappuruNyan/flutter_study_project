import 'package:equatable/equatable.dart';

import '../../data/models/employee_model.dart';
import '../../data/models/workplase_model.dart';

class Booking extends Equatable{
  const Booking({
    required this.id,
    required this.holder,
    required this.maker,
    required this.workplace,
    required this.start,
    required this.end,
    required this.guests,
  });

  final int id;
  final EmployeeModel holder;
  final EmployeeModel maker;
  final WorkplaceModel workplace;
  final DateTime start;
  final DateTime end;
  final int guests;

  @override
  List<Object> get props => [id, holder, maker, workplace, start, end, guests];
}
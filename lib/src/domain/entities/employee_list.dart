import 'package:equatable/equatable.dart';

import 'employee.dart';

class EmployeeList extends Equatable{

  const EmployeeList({
    required this.employees
  });
  final List<Employee> employees;

  @override
  List<Object> get props => [employees];
}
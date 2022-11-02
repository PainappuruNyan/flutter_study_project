import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/employee.dart';
import '../repository/employee_repository.dart';

class GetEmployeeById{
  GetEmployeeById(this.repository);
  final EmployeeRepository repository;

  Future<Either<Failure, Employee>> execute({
  required int id
}) async {
    return await repository.getEmployeeById(id);
  }
}

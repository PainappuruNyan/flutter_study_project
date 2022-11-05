import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/employee.dart';
import '../repository/employee_repository.dart';

class GetEmployeeByLogin{
  GetEmployeeByLogin(this.repository);
  final EmployeeRepository repository;

  Future<Either<Failure, Employee>> execute({
    required String login
  }) async {
    return await repository.getEmployeeByLogin(login);
  }
}

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/employee.dart';

abstract class EmployeeRepository{
  Future<Either<Failure, Employee>> getEmployeeById(int id);
  Future<Either<Failure, Employee>> getEmployeeByLogin(String login);
}

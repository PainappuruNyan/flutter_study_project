import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/employee_list.dart';

abstract class EmployeeListRepository{
  Future<Either<Failure, EmployeeList>> getEmployeeByName(String query, int page);
}
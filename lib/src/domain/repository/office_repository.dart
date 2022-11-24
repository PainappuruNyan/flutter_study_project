import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/office.dart';
import '../entities/office_list_.dart';

abstract class OfficeRepository{
  Future<Either<Failure, OfficeList>> getOffices();
  Future<Either<Failure, Office>> getOfficeById(int id);
}

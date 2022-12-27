import 'package:dartz/dartz.dart';

import '../../bloc/office_create_2/office_create_2_bloc.dart';
import '../../core/error/failures.dart';
import '../../data/models/new_admin_model.dart';
import '../../data/models/office_model.dart';
import '../entities/office_list_.dart';

abstract class AdministrationRepository{
  Future<Either<Failure, OfficeList>> getAdministratorOffices(int adminId);
  Future<Either<Failure, String>> postOffice(OfficeModel office);
  Future<Either<Failure, String>> postFloors(List<MiniFloor> floors);
  Future<Either<Failure, String>> deleteOffice(int id);
  Future<Either<Failure, String>> postAdmin(NewAdminModel admin);
  Future<Either<Failure, String>> editOffice(OfficeModel office);
}

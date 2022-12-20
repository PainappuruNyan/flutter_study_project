import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/models/teammate_model.dart';
import '../entities/teammate_list.dart';

abstract class TeammateListRepository{
  Future<Either<Failure, TeammateList>> getTeammate({required int teamId});
  Future<Either<Failure, String>> deleteTeammate({required int teamId, required int employeeId});
  Future<Either<Failure, String>> addTeammate({required TeammateModel teammate});
}

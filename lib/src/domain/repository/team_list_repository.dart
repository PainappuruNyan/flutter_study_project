import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/models/team_model.dart';
import '../entities/team_list.dart';

abstract class TeamListRepository{
  Future<Either<Failure, TeamList>> getMyTeam({required int id});
  Future<Either<Failure, String>> postNewTeam({required TeamModel team});
  Future<Either<Failure, String>> deleteTeam({required int id});
  Future<Either<Failure, String>> editTeam({required TeamModel team});
}

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/models/team_model.dart';
import '../entities/team_list.dart';

abstract class TeamListRepository{
  Future<Either<Failure, TeamList>> getMyTeam();
  Future<Either<Failure, TeamList>> getAllTeam();
  Future<Either<Failure, String>> postNewTeam({required TeamModel team});
}
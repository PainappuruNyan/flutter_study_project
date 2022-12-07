import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/teammate_list.dart';

abstract class TeammateListRepository{
  Future<Either<Failure, TeammateList>> getTeammate({required int teamId});
}

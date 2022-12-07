import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/teammate_list.dart';
import '../../domain/repository/teammate_list_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/teammate_list_model.dart';

class TeammateRepositoryImpl implements TeammateListRepository {
  TeammateRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, TeammateList>> getTeammate({required int teamId}) async {
    try {
      final TeammateListModel remoteTeammate = await remoteDataSource
          .getTeammate(teamId: teamId);
      return Right(remoteTeammate);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
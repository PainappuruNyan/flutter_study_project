import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/team_list.dart';
import '../../domain/repository/team_list_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/team_list_model.dart';
import '../models/team_model.dart';

class TeamRepositoryImpl implements TeamListRepository {
  TeamRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, TeamList>> getMyTeam() async {
    try {
      final TeamListModel remoteMyTeams = await remoteDataSource.getMyTeam();
      return Right(remoteMyTeams);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, TeamList>> getAllTeam() async {
    try {
      final TeamListModel remoteAllTeam = await remoteDataSource.getAllTeam();
      return Right(remoteAllTeam);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> postNewTeam({required TeamModel team}) async {
    try {
      final String successString =
          await remoteDataSource.postNewTeam(team: team);
      return Right(successString);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteTeam({required int id}) async {
    try {
      final String successString = await remoteDataSource.deleteTeam(id: id);
      return Right(successString);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}

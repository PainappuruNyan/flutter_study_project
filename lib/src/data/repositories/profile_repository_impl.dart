import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repository/profile_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/profile_model.dart';

// typedef Future<Employee> GetEmployeeByIdOrLogin();

class ProfileRepositoryImpl implements ProfileRepository{
  ProfileRepositoryImpl( {
    required this.networkInfo,
    required this.remoteDataSource,
  });
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    try{
      final ProfileModel remoteProfile = await remoteDataSource.getProfile();
      return Right(remoteProfile);
    }
    on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Profile>> getProfileByCredits(String username, String password) async {
    try{
      final ProfileModel remoteProfile = await remoteDataSource.getProfileByCredits(username, password);
      return Right(remoteProfile);
    }
    on ServerException {
      return Left(ServerFailure());
    }
  }

}

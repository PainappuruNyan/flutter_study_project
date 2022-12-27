import 'package:dartz/dartz.dart';

import '../../bloc/office_create_2/office_create_2_bloc.dart';
import '../../core/error/failures.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/office_list_.dart';
import '../../domain/repository/administration_repository.dart';
import '../datasources/local/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/new_admin_model.dart';
import '../models/office_model.dart';

// typedef Future<Employee> GetEmployeeByIdOrLogin();

class AdministrationRepositoryImpl implements AdministrationRepository{
  AdministrationRepositoryImpl( {
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource
  });
  final RemoteDataSource remoteDataSource;
  final LocalDataSourceImpl localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, OfficeList>> getAdministratorOffices(int adminId) async {
    try {
      final OfficeList answer = await remoteDataSource.getAdminOffices(adminId);
      return Right(answer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }


  @override
  Future<Either<Failure, String>> postOffice(OfficeModel office) async {
    try {
      final String answer = await remoteDataSource.postOffice(office);
      return Right(answer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteOffice(int id) async {
    try{
      final String successString = await remoteDataSource.deleteOffice(id: id);
      return Right(successString);
    }
    on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> postFloors(List<MiniFloor> floors) async {
    try {
      final String answer = await remoteDataSource.postFloors(floors);
      return Right(answer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> postAdmin(NewAdminModel admin) async {
    try {
      final String answer = await remoteDataSource.postAdmin(admin);
      return Right(answer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> editOffice(OfficeModel office) async {
    try {
      final String answer = await remoteDataSource.editOffice(office);
      return Right(answer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/repository/employee_list_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/employee_list_model.dart';


class EmployeeListRepositoryImpl implements EmployeeListRepository {
  EmployeeListRepositoryImpl(
      {required this.networkInfo,
        required this.remoteDataSource,});

  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, EmployeeListModel>> getEmployeeByName(
      String query, int page) async {
    // if(await networkInfo.isConnected){
    try {
      final EmployeeListModel remoteEmployeeList =
      await remoteDataSource.getEmployeeByName(query, page);
      return Right(remoteEmployeeList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/employee.dart';
import '../../domain/repository/employee_repository.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/employee_model.dart';

// typedef Future<Employee> GetEmployeeByIdOrLogin();

class EmployeeRepositoryImpl implements EmployeeRepository{
  EmployeeRepositoryImpl( {
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource
  });
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Employee>> getEmployeeById(int id) async{
    if(await networkInfo.isConnected){
      try{
        final EmployeeModel remoteEmployee = await remoteDataSource.getEmployeeById(id);
        localDataSource.cacheEmployee(remoteEmployee);
        return Right(remoteEmployee);
      }
      on ServerException{
        return Left(ServerFailure());
      }
    }else{
      try{
        final EmployeeModel localEmployee = await localDataSource.getCachedEmployee();
        return Right(localEmployee);
      }
      on EmptyCacheException{
        return Left(EmptyCasheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Employee>> getEmployeeByLogin(String login) async {
    if(await networkInfo.isConnected){
      try{
        final EmployeeModel remoteEmployee = await remoteDataSource.getEmployeeByLogin(login);
        localDataSource.cacheEmployee(remoteEmployee);
        return Right(remoteEmployee);
      }
      on ServerException{
        return Left(ServerFailure());
      }
    }else{
      try{
        final EmployeeModel localEmployee = await localDataSource.getCachedEmployee();
        return Right(localEmployee);
      }
      on EmptyCacheException{
        return Left(EmptyCasheFailure());
      }
    }
  }

  // Future<Either<Failure, Employee>> _getEmployee(
  //     GetEmployeeByIdOrLogin Function() getEmployeeByIdOrLogin) async {
  //
  //   if(await networkInfo.isConnected){
  //     try{
  //       final remoteEmployee = await getEmployeeByIdOrLogin();
  //       localDataSource.cacheEmployee(remoteEmployee);
  //       return Right(remoteEmployee);
  //     }
  //     on ServerException{
  //       return Left(ServerFailure());
  //     }
  //   }else{
  //     try{
  //       final EmployeeModel localEmployee = await localDataSource.getCachedEmployee();
  //       return Right(localEmployee);
  //     }
  //     on EmptyCacheException{
  //       return Left(EmptyCasheFailure());
  //     }
  //   }
  // }
}

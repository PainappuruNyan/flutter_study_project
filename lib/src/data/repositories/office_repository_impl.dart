import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/office.dart';
import '../../domain/entities/office_list_.dart';
import '../../domain/repository/office_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/office_list_model.dart';
import '../models/office_model.dart';

// typedef Future<Employee> GetEmployeeByIdOrLogin();

class OfficeRepositoryImpl implements OfficeRepository{
  OfficeRepositoryImpl( {
    required this.networkInfo,
    required this.remoteDataSource,
  });
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Office>> getOfficeById(int id) async {
    try{
      final OfficeModel remoteOffice = await remoteDataSource.getOfficeById(id);
      return Right(remoteOffice);
    }
    on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OfficeList>> getOffices() async {
    try{
      final OfficeListModel remoteOffices = await remoteDataSource.getOffices();
      return Right(remoteOffices);
    }
    on ServerException {
      return Left(ServerFailure());
    }
  }
}

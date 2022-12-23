import 'package:dartz/dartz.dart';

import '../../bloc/office_create_2/office_create_2_bloc.dart';
import '../../core/error/failures.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/city_list.dart';
import '../../domain/entities/office.dart';
import '../../domain/entities/office_list_.dart';
import '../../domain/repository/office_repository.dart';
import '../datasources/local/DAO/favorite_office_id.dart';
import '../datasources/local/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/city_list_model.dart';
import '../models/office_list_model.dart';
import '../models/office_model.dart';

// typedef Future<Employee> GetEmployeeByIdOrLogin();

class OfficeRepositoryImpl implements OfficeRepository {
  OfficeRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  final LocalDataSourceImpl localDataSource;
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Office>> getOfficeById(int id) async {
    try {
      final OfficeModel remoteOffice = await remoteDataSource.getOfficeById(id);
      return Right(remoteOffice);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OfficeList>> getOffices() async {
    try {
      final List<OfficeId> favorites =
          await localDataSource.getFavoritesOffices();
      final OfficeListModel remoteOffices = await remoteDataSource.getOffices();
      for (Office remoteElement in remoteOffices.offices) {
        if (favorites
            .any((OfficeId element) => element.officeId == remoteElement.id)) {
          remoteElement.isFavorite = true;
        }
      }
      return Right(remoteOffices);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<OfficeId>>> getFavorites() async {
    final List<OfficeId> favoritesOffices =
        await localDataSource.getFavoritesOffices();
    return Right(favoritesOffices);
  }

  @override
  Future<void> changeFavorite(int id, bool isFavorite) async {
    await localDataSource.changeFavorite(id, isFavorite);
  }

  @override
  Future<Either<Failure, CityList>> getCites() async {
    try {
      final CityListModel remoteCites = await remoteDataSource.getCitesAll();
      return Right(remoteCites);
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
  Future<Either<Failure, String>> postFloors(List<MiniFloor> floors) async {
    try {
      final String answer = await remoteDataSource.postFloors(floors);
      return Right(answer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

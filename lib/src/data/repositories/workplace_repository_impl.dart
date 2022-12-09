import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/floor_list.dart';
import '../../domain/repository/workplace_repository.dart';
import '../datasources/local/DAO/favorite_places_id.dart';
import '../datasources/local/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/floor_list_model.dart';

// typedef Future<Employee> GetEmployeeByIdOrLogin();

class WorkplaceRepositoryImpl implements WorkplaceRepository{

  WorkplaceRepositoryImpl( {
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource
  });
  final LocalDataSourceImpl localDataSource;
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<void> changeFavorite(int id, bool isFavorite) {
    // TODO: implement changeFavorite
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PlaceId>>> getFavorites() {
    // TODO: implement getFavorites
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, FloorList>> getFloors(int officeId) async {
    try{
      final FloorListModel remoteFloors = await remoteDataSource.getFloors(officeId);
      return Right(remoteFloors);
    }
    on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FloorList>> getWorkplaces(int floorId) {
    // TODO: implement getWorkplaces
    throw UnimplementedError();
  }


}

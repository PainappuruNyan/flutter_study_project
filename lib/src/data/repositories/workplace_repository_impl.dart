import 'package:dartz/dartz.dart';

import '../../bloc/office_create_2/office_create_2_bloc.dart';
import '../../core/error/failures.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/floor.dart';
import '../../domain/entities/floor_list.dart';
import '../../domain/entities/workplace.dart';
import '../../domain/entities/time_interval_list.dart';
import '../../domain/entities/workplace_list.dart';
import '../../domain/repository/workplace_repository.dart';
import '../datasources/local/DAO/favorite_places_id.dart';
import '../datasources/local/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/floor_list_model.dart';
import '../models/workplace_list_model.dart';
import '../models/workplase_model.dart';

// typedef Future<Employee> GetEmployeeByIdOrLogin();

class WorkplaceRepositoryImpl implements WorkplaceRepository {
  WorkplaceRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

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
    try {
      final FloorListModel remoteFloors =
          await remoteDataSource.getFloors(officeId);
      remoteFloors.floors.sort((a, b) => a.floorNumber.compareTo(b.floorNumber));
      return Right(remoteFloors);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WorkplaceList>> getWorkplaces(
      int floorId, DateTime start, DateTime end) async {
    try {
      final WorkplaceListModel remotePlaces =
          await remoteDataSource.getWorkplaces(floorId, 1, start, end);
      return Right(remotePlaces);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WorkplaceList>> getMeetingRooms(
      int floorId, DateTime start, DateTime end) async {
    try {
      final WorkplaceListModel remoteFloors =
          await remoteDataSource.getWorkplaces(floorId, 2, start, end);
      return Right(remoteFloors);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, TimeIntervalList>> getFreeIntervals(
      int placeId, DateTime dateTime) async {
    try {
      final TimeIntervalList intervalList =
          await remoteDataSource.getFreeIntervals(placeId, dateTime);
      return Right(intervalList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WorkplaceList>> getRemoteFavorites(
      int floorId, DateTime start, DateTime end) async {
    try {
      final WorkplaceListModel remoteFavorites =
          await remoteDataSource.getRemoteFavorites(floorId, start, end);
      return Right(remoteFavorites);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> changeRemoteFavorites(
      int id, bool isFavorite) async {
    try {
      String answer = '';
      if (isFavorite) {
        answer = await remoteDataSource.postFavorite(id);
      } else {
        answer = await remoteDataSource.deleteFavorite(id);
      }
      print(answer);
      return Right(answer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MiniFloor>>> getMiniFloors(List<Floor> floors) async {
    try{
      List<MiniFloor> miniFloors = [];
      for(Floor f in floors){
        final WorkplaceListModel remoteWorkplace = await remoteDataSource.getWorkplacesByFloor(f.id!, 1);
        final WorkplaceListModel remoteMeetingRooms = await remoteDataSource.getWorkplacesByFloor(f.id!, 2);
        MiniFloor nMiniFloor = MiniFloor(floorNumber: f.floorNumber, officeId: f.officeId, floorId: f.id);
        nMiniFloor.nWorkplaces = remoteWorkplace.places.map((Workplace e) => MiniWorkplace.fromEntity(e, 1)).toList();
        nMiniFloor.nMeetingRooms = remoteMeetingRooms.places.map((Workplace e) => MiniWorkplace.fromEntity(e, 2)).toList();
        miniFloors.add(nMiniFloor);
      }
      miniFloors.sort((a, b) => a.floorNumber.compareTo(b.floorNumber));
      return Right(miniFloors);
    }
    on ServerException {
      print('workplace_repository_impl:getMiniFloors Ошибка при создании MiniFloors');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> postFloorImage(String imagePath, int floorId) async {
    try {
      String answer = '';
      answer = await remoteDataSource.postFloorImage(imagePath, floorId);
      print(answer);
      return Right(answer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WorkplaceList>> getWorkplacesByFloor(int floorId, int typeId) async {
    try {
      final WorkplaceListModel remoteFavorites =
          await remoteDataSource.getWorkplacesByFloor(floorId, typeId);
      return Right(remoteFavorites);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Floor>> getFloor(int floorId) async  {
    try {
      final Floor remoteFloor =
          await remoteDataSource.getFloor(floorId);
      return Right(remoteFloor);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteWorkplace(int placeId) async{
    try {
      String answer = '';
      answer = await remoteDataSource.deleteWorkplace(placeId);
      print(answer);
      return Right(answer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> postWorkplace(WorkplaceModel place) async {
    try {
      String answer = '';
      answer = await remoteDataSource.postWorkplace(place);
      print(answer);
      return Right(answer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateWorkplace(WorkplaceModel place) async {
    try {
      String answer = '';
      answer = await remoteDataSource.updateWorkplace(place);
      print(answer);
      return Right(answer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }



}

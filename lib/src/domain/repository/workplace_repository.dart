import 'package:dartz/dartz.dart';

import '../../bloc/office_create_2/office_create_2_bloc.dart';
import '../../core/error/failures.dart';
import '../../data/datasources/local/DAO/favorite_places_id.dart';
import '../entities/floor.dart';
import '../entities/floor_list.dart';
import '../entities/time_interval_list.dart';
import '../entities/workplace_list.dart';

abstract class WorkplaceRepository{
  Future<Either<Failure, List<PlaceId>>> getFavorites();
  Future<void> changeFavorite(int id, bool isFavorite);
  Future<Either<Failure, FloorList>> getFloors(int officeId);
  Future<Either<Failure, WorkplaceList>> getWorkplaces(int floorId, DateTime start, DateTime end);
  Future<Either<Failure, WorkplaceList>> getMeetingRooms(int floorId, DateTime start, DateTime end);
  Future<Either<Failure, TimeIntervalList>> getFreeIntervals(int placeId, DateTime date);
  Future<Either<Failure, WorkplaceList>> getRemoteFavorites(int floorId, DateTime start, DateTime end);
  Future<Either<Failure, String>> changeRemoteFavorites(int id, bool isFavorite);
  Future<Either<Failure, List<MiniFloor>>> getMiniFloors(List<Floor> floors);
}

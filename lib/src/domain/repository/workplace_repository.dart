import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/datasources/local/DAO/favorite_places_id.dart';
import '../entities/floor_list.dart';

abstract class WorkplaceRepository{
  Future<Either<Failure, List<PlaceId>>> getFavorites();
  Future<void> changeFavorite(int id, bool isFavorite);
  Future<Either<Failure, FloorList>> getFloors(int officeId);
  Future<Either<Failure, FloorList>> getWorkplaces(int floorId);
}

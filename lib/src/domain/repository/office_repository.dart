import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/datasources/local/DAO/favorite_office_id.dart';
import '../entities/city_list.dart';
import '../entities/office.dart';
import '../entities/office_list_.dart';

abstract class OfficeRepository{
  Future<Either<Failure, OfficeList>> getOffices();
  Future<Either<Failure, Office>> getOfficeById(int id);
  Future<Either<Failure, List<OfficeId>>> getFavorites();
  Future<void> changeFavorite(int id, bool isFavorite);
  Future<Either<Failure, CityList>> getCites();
}

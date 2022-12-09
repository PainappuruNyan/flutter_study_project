import 'package:floor/floor.dart';

import 'favorite_office_id.dart';
import 'favorite_places_id.dart';

@dao
abstract class FavoritesDao{

  @Query('SELECT * FROM FavoritesOffices')
  Future<List<OfficeId>> getAllOffices();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavoriteOffice(OfficeId office);

  @Query('DELETE FROM FavoritesOffices WHERE officeId = :id')
  Future<void> deleteFavoriteOffice(int id);

  @Query('SELECT * FROM FavoritesPlaces')
  Future<List<PlaceId>> getAllPlaces();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavoritePlace(PlaceId place);

  @delete
  Future<void> deleteFavoritePlace(PlaceId place);
}

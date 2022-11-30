import 'package:floor/floor.dart';

import 'DAO/favorite_office_id.dart';
import 'DAO/favorite_places_id.dart';
import 'DAO/favorites_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [OfficeId, PlaceId])
abstract class AppDatabase extends FloorDatabase {
   FavoritesDao get favoritesDao;
}
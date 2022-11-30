import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'FavoritesPlaces')
class PlaceId extends Equatable{
  const PlaceId(this.id, this.placeId);

  @PrimaryKey(autoGenerate: true)
  final int id;
  final int placeId;

  @override
  List<Object?> get props => [id, placeId];
}
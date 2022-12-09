import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'FavoritesOffices')
class OfficeId extends Equatable{
  const OfficeId({this.id, required this.officeId});

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int officeId;

  @override
  List<Object?> get props => [id, officeId];
}
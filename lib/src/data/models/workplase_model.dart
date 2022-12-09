
import '../../domain/entities/workplace.dart';

class WorkplaceModel extends Workplace{
  WorkplaceModel(super.isFree,{
    required super.id,
    required super.capacity,
    required super.floorId,
    required super.typeName});

  factory WorkplaceModel.fromJson(Map<String, dynamic> json, bool isFree){
    return WorkplaceModel(
        isFree,
        id: json['id'] as int,
        capacity: json['capacity'] as int,
        floorId: json['floor_id'] as int,
        typeName: json['type_id'] as String);
  }

  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      'id':id,
      'capacity':capacity,
      'floor_id':floorId,
      'type_id':typeName
    };
  }
}

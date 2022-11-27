
import '../../domain/entities/workplace.dart';

class WorkplaceModel extends Workplace{
  WorkplaceModel(super.isFree,{
    required super.id,
    required super.capacity,
    required super.floor_id,
    required super.type_id});

  factory WorkplaceModel.fromJson(Map<String, dynamic> json, bool isFree){
    return WorkplaceModel(
        isFree,
        id: json['id'] as int,
        capacity: json['capacity'] as int,
        floor_id: json['floor_id'] as int,
        type_id: json['type_id'] as int);
  }

  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      'id':id,
      'capacity':capacity,
      'floor_id':floor_id,
      'type_id':type_id
    };
  }
}

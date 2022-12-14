
import '../../domain/entities/workplace.dart';

class WorkplaceModel extends Workplace{
  const WorkplaceModel({
    required super.isFree,
    required super.id,
    required super.capacity,
    required super.floorId,
    required super.typeName});

  factory WorkplaceModel.fromJson(Map<String, dynamic> json){
    return WorkplaceModel(
        id: json['id'] as int,
        capacity: json['capacity'] as int,
        floorId: json['floorId'] as int,
        typeName: json['typeName'] as String,
        isFree: json['isFree'] as bool);
  }

  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      'id':id,
      'capacity':capacity,
      'floorId':floorId,
      'typeName':typeName,
      'isFree':isFree,
    };
  }
}

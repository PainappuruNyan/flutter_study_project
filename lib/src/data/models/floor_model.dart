import '../../bloc/office_create_2/office_create_2_bloc.dart';
import '../../domain/entities/floor.dart';

class FloorModel extends Floor{
  FloorModel({
    required super.id,
    required super.officeId,
    required super.floorNumber,
    required super.mapFloor,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) => FloorModel(
    id: json['id'] as int,
    officeId: json['officeId'] as int,
    floorNumber: json['floorNumber'] as int,
    mapFloor: json['imageId']==null ? null : json['imageId'] as int,
  );

  factory FloorModel.fromMini(MiniFloor miniFloor){
    return FloorModel(
        id: null,
        officeId: miniFloor.officeId,
        floorNumber: miniFloor.floorNumber,
        mapFloor: null);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'officeId': officeId,
    'floorNumber': floorNumber,
    'mapFloor': mapFloor,
  };
}
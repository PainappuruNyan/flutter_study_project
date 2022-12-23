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
    mapFloor: json['mapFloor']==null ? '' : json['mapFloor'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'officeId': officeId,
    'floorNumber': floorNumber,
    'mapFloor': mapFloor,
  };
}
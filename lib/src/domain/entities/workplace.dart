import 'package:equatable/equatable.dart';

class Workplace extends Equatable {
  Workplace({
    this.isFree,
    this.id,
    this.typeName,
    this.typeId,
    required this.floorId,
    required this.capacity,
    this.placeName,
  });

  final int? id;
  final String? typeName;
  final int floorId;
  int capacity;
  final int? typeId;
  final bool? isFree;
  String? placeName;

  Workplace copyWith({
    int? id,
    String? typeName,
    int? floorId,
    int? capacity,
    int? typeId,
    bool? isFree,
    String? placeName,
  }) {
    return Workplace(
        floorId: floorId ?? this.floorId,
        capacity: capacity ?? this.capacity,
        id: id ?? this.id,
        typeName: typeName ?? this.typeName,
        typeId: typeId ?? this.typeId,
        isFree: isFree ?? this.isFree,
        placeName: placeName ?? this.placeName
    );
  }

  @override
  List<Object?> get props => [id, typeName, floorId, capacity, isFree, placeName];
}

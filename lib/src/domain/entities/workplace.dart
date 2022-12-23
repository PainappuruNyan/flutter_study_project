import 'package:equatable/equatable.dart';

class Workplace extends Equatable{
  const Workplace({
    this.isFree,
    this.id,
    this.typeName,
    this.typeId,
    required this.floorId,
    required this.capacity,
  });

  final int? id;
  final String? typeName;
  final int floorId;
  final int capacity;
  final int? typeId;
  final bool? isFree;

  @override
  List<Object?> get props => [id, typeName, floorId, capacity, isFree];
}

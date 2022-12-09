import 'package:equatable/equatable.dart';

class Workplace extends Equatable{
  const Workplace(this.isFree, {
    required this.id,
    required this.typeName,
    required this.floorId,
    required this.capacity,
  });

  final int id;
  final String typeName;
  final int floorId;
  final int capacity;
  final bool? isFree;

  @override
  List<Object> get props => [id, typeName, floorId, capacity];
}

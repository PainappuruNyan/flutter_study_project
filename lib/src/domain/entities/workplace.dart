import 'package:equatable/equatable.dart';

class Workplace extends Equatable{
  const Workplace(this.isFree, {
    required this.id,
    required this.type_id,
    required this.floor_id,
    required this.capacity,
  });

  final int id;
  final int type_id;
  final int floor_id;
  final int capacity;
  final bool? isFree;

  @override
  List<Object> get props => [id, type_id, floor_id, capacity];
}

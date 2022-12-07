import 'package:equatable/equatable.dart';
class Team extends Equatable{
  const Team({
    required this.id,
    required this.leaderId,
    required this.name,
  });

  final int id;
  final int leaderId;
  final String name;
  @override
  List<Object> get props => [id, leaderId, name];
}

import 'package:equatable/equatable.dart';
class Team extends Equatable{
  const Team({
    required this.id,
    required this.leaderId,
    required this.leaderName,
    required this.name,
    required this.membersNumber,
  });

  final int id;
  final int leaderId;
  final String leaderName;
  final String name;
  final int membersNumber;
  @override
  List<Object> get props => [id, leaderId, leaderName, name, membersNumber];
}

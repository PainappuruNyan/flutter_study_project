import 'package:equatable/equatable.dart';

class Teammate extends Equatable{
  const Teammate({
    required this.id,
    required this.teamId,
    required this.employeeId,
  });

  final int id;
  final int teamId;
  final int employeeId;
  @override
  List<Object> get props => [id, teamId, employeeId];
}

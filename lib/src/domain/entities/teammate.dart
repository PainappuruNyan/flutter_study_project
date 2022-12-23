import 'package:equatable/equatable.dart';

class Teammate extends Equatable{
  const Teammate({
    required this.id,
    required this.teamId,
    required this.employeeId,
    required this.fullName,
    required this.roleName
  });

  final int id;
  final int teamId;
  final int employeeId;
  final String? fullName;
  final String? roleName;
  @override
  List<Object?> get props => [id, teamId, employeeId, fullName, roleName];
}


// "id": 1,
// "teamId": 1,
// "employeeId": 1,
// "fullName": "Ольга Ивановна Ли",
// "roleName": "ROLE_ADMIN"
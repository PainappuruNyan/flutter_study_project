import '../../domain/entities/teammate.dart';

class TeammateModel extends Teammate {
  const TeammateModel({
    required super.id,
    required super.teamId,
    required super.employeeId,
    required super.fullName,
    required super.roleName
  });

  factory TeammateModel.fromJson(Map<String, dynamic> json) {
    return TeammateModel(
      id: json['id'] as int,
      teamId: json['teamId'] as int,
      employeeId: json['employeeId'] as int,
      fullName: json['fullName'] as String,
      roleName: json['roleName'] as String
    );
  }

  String get roleString{
    if(roleName == 'ROLE_ADMIN'){
      return 'Админ';
    }
    return 'Сотрудник';
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'teamId': teamId,
      'employeeId': employeeId,
      'fullName': fullName,
      'roleName': roleName,
    };
  }
}

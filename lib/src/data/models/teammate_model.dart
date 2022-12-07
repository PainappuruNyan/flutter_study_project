import '../../domain/entities/teammate.dart';

class TeammateModel extends Teammate{
  const TeammateModel({required super.id, required super.teamId, required super.employeeId});

  factory TeammateModel.fromJson(Map<String, dynamic> json){
    return TeammateModel(
      id: json['id'] as int,
      teamId: json['teamId'] as int,
      employeeId: json['employeeId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'teamId': teamId,
      'employeeId': employeeId,
    };
  }
}
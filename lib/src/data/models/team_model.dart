import '../../domain/entities/team.dart';

class TeamModel extends Team {
  const TeamModel(
      {required super.id,
      required super.leaderId,
      required super.leaderName,
      required super.name,
      required super.membersNumber});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] as int,
      leaderId: json['leaderId'] as int,
      leaderName: json['leaderName'] as String,
      name: json['name'] as String,
      membersNumber: json['membersNumber'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'leaderId': leaderId,
      'leaderName': leaderName,
      'name': name,
      'membersNumber': membersNumber,
    };
  }
}

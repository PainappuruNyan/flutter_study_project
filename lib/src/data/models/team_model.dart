import '../../domain/entities/team.dart';

class TeamModel extends Team{
  const TeamModel({required super.id, required super.leaderId, required super.name});

  factory TeamModel.fromJson(Map<String, dynamic> json){
    return TeamModel(
      id: json['id'] as int,
      leaderId: json['leaderId'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'leaderId': leaderId,
      'name': name,
    };
  }
}

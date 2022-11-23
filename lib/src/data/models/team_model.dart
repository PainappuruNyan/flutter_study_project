import '../../domain/entities/team.dart';

class TeamModel extends Team{
  TeamModel({required super.id});

  factory TeamModel.fromJson(Map<String, dynamic> json){
    return TeamModel(id: json['id'] as int);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id
    };
  }
}

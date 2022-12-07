import '../../domain/entities/team_list.dart';
import 'team_model.dart';

class TeamListModel extends TeamList{
  const TeamListModel({required super.teams});

  factory TeamListModel.fromJson(List<dynamic> json) {
    final List<TeamModel> teams = json.map((i)=>TeamModel.fromJson(i as Map<String, dynamic>)).toList();
    return TeamListModel(teams: teams);
  }
}
import 'package:equatable/equatable.dart';

import '../../data/models/team_model.dart';

class TeamList extends Equatable{

  const TeamList({
    required this.teams
  });
  final List<TeamModel> teams;

  @override
  List<Object> get props => [teams];
}

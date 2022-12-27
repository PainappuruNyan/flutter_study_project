part of 'team_list_bloc.dart';

@immutable
abstract class TeamListEvent extends Equatable {
  const TeamListEvent();
}

class GetTeamList extends TeamListEvent {
  const GetTeamList();


  @override
  List<Object?> get props => [];
}
class TeamDelete extends TeamListEvent{
  const TeamDelete({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}

class TeamEdit extends TeamListEvent {
  const TeamEdit({required this.team});

  final TeamModel team;

  @override
  List<Object?> get props => [team];
}

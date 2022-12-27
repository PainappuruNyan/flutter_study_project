part of 'team_list_bloc.dart';

@immutable
abstract class TeamListState extends Equatable{
  const TeamListState();
}

class TeamListInitial extends TeamListState {
  const TeamListInitial();

  @override
  List<Object?> get props => [];
}

class TeamListLoading extends TeamListState {
  const TeamListLoading();

  @override
  List<Object?> get props => [];
}

class TeamListLoaded extends TeamListState {
  const TeamListLoaded({required this.myTeamList});
  final TeamList myTeamList;

  @override
  List<Object?> get props => [myTeamList];

  int get lengthMyTeam => myTeamList.teams.length;
}

class TeamListError extends TeamListState {
  const TeamListError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

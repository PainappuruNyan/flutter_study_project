part of 'team_create_bloc.dart';

abstract class TeamCreateEvent extends Equatable {
  const TeamCreateEvent();

  @override
  List<Object> get props => [];
}

class TeamCreateStart extends TeamCreateEvent{}

class TeamCreateInfoSelected extends TeamCreateEvent{
  const TeamCreateInfoSelected({required this.team});

  final TeamModel team;
}

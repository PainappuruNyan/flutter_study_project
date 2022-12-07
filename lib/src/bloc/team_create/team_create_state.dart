part of 'team_create_bloc.dart';

abstract class TeamCreateState extends Equatable {
  const TeamCreateState();
}

class TeamCreateInitial extends TeamCreateState {
  @override
  List<Object> get props => [];
}

class TeamCreateLoaded extends TeamCreateState {
  const TeamCreateLoaded();

  @override
  List<Object?> get props => [];
}

class TeamCreateLoading extends TeamCreateState {
  @override
  List<Object?> get props => [];
}

class TeamCreateSuccess extends TeamCreateState {
  const TeamCreateSuccess();

  @override
  List<Object?> get props => [];
}


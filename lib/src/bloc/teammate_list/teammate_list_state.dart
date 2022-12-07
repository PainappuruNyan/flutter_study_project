part of 'teammate_list_bloc.dart';

@immutable
abstract class TeammateListState extends Equatable{
  const TeammateListState();
}

class TeammateListInitial extends TeammateListState {
  const TeammateListInitial();

  @override
  List<Object?> get props => [];
}

class TeammateListLoading extends TeammateListState {
  const TeammateListLoading();

  @override
  List<Object?> get props => [];
}

class TeammateListLoaded extends TeammateListState {
  const TeammateListLoaded({required this.teammateList});
  final TeammateList teammateList;

  @override
  List<Object?> get props => [teammateList];

  int get lengthTeammate => teammateList.teammates.length;
}

class TeammateListError extends TeammateListState {
  const TeammateListError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

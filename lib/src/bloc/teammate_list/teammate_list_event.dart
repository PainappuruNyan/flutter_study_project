part of 'teammate_list_bloc.dart';

@immutable
abstract class TeammateListEvent {}

class GetTeammateList extends TeammateListEvent {

  GetTeammateList({required this.teamId});

  final int teamId;

}

class TeammateDelete extends TeammateListEvent{
  TeammateDelete({required this.teamId, required this.employeeId});

  final int teamId;
  final int employeeId;
}

class TeammateAdd extends TeammateListEvent{
  TeammateAdd({required this.teammate});

  final TeammateModel teammate;
}

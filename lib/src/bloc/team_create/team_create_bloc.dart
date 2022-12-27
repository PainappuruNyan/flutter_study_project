import 'dart:async';

import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../data/models/team_model.dart';
import '../../data/repositories/team_repository_impl.dart';

part 'team_create_event.dart';
part 'team_create_state.dart';

class TeamCreateBloc extends Bloc<TeamCreateEvent, TeamCreateState> {
  TeamCreateBloc() : super(TeamCreateInitial()) {
    on<TeamCreateStart>(_onStart);
    on<TeamCreateInfoSelected>(_onInfoSelected);
  }

  FutureOr<void> _onStart(
      TeamCreateStart event, Emitter<TeamCreateState> emit) async {
    emit(TeamCreateInitial());

    emit(const TeamCreateLoaded());
  }

  Future<void> _onInfoSelected(TeamCreateInfoSelected event,
      Emitter<TeamCreateState> emit) async {
    final TeamRepositoryImpl teamRepositoryImpl = di.sl();

    await teamRepositoryImpl
        .postNewTeam(team: event.team)
        .then((Either<Failure, String> value) {
      value.fold((Failure l) => print(l.toString()), (String r) async {
        emit(const TeamCreateSuccess());
      });
    });
  }

}

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../core/error/failures.dart';
import '../../data/models/team_model.dart';
import '../../data/repositories/team_repository_impl.dart';
import '../../domain/entities/team_list.dart';

part 'team_list_event.dart';

part 'team_list_state.dart';

class TeamListBloc extends Bloc<TeamListEvent, TeamListState> {
  TeamListBloc(this._teamRepository) : super(const TeamListInitial()) {
    on<GetTeamList>((GetTeamList event, Emitter<TeamListState> emit) async {
      emit(const TeamListLoading());
      TeamList myTeamList = TeamList(teams: []);
      await _teamRepository.getMyTeam().then((Either<Failure, TeamList> value) {
        value.fold((Failure l) async {
          emit(TeamListError(l.toString()));
        }, (TeamList r) async {
          myTeamList = r;
        });
      });

      TeamList allTeamList = TeamList(teams: []);
      await _teamRepository
          .getAllTeam()
          .then((Either<Failure, TeamList> value) {
        value.fold((Failure l) async {
          emit(TeamListError(l.toString()));
        }, (TeamList r) async {
          allTeamList = r;
        });
      });
      emit(TeamListLoaded(myTeamList: myTeamList, allTeamList: allTeamList));
    });
    on<TeamDelete>((TeamDelete event, Emitter<TeamListState> emit) async {
      await _teamRepository
          .deleteTeam(id: event.id)
          .then((value) => GetTeamList())
          .catchError(onError);
      emit(const TeamListLoading());
      TeamList myTeamList = TeamList(teams: []);
      await _teamRepository.getMyTeam().then((Either<Failure, TeamList> value) {
        value.fold((Failure l) async {
          emit(TeamListError(l.toString()));
        }, (TeamList r) async {
          myTeamList = r;
        });
      });

      TeamList allTeamList = TeamList(teams: []);
      await _teamRepository
          .getAllTeam()
          .then((Either<Failure, TeamList> value) {
        value.fold((Failure l) async {
          emit(TeamListError(l.toString()));
        }, (TeamList r) async {
          allTeamList = r;
        });
      });
      emit(TeamListLoaded(myTeamList: myTeamList, allTeamList: allTeamList));
    });

  }

  final TeamRepositoryImpl _teamRepository;
}

import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      await _teamRepository.getMyTeam(id: prefs.getInt('id')!).then((Either<Failure, TeamList> value) {
        value.fold((Failure l) async {
          emit(TeamListError(l.toString()));
        }, (TeamList r) async {
          myTeamList = r;
        });
      });
      emit(TeamListLoaded(myTeamList: myTeamList));
    });
    on<TeamDelete>((TeamDelete event, Emitter<TeamListState> emit) async {
      await _teamRepository
          .deleteTeam(id: event.id)
          .then((value) => GetTeamList())
          .catchError(onError);
      emit(const TeamListLoading());
      TeamList myTeamList = TeamList(teams: []);
      await _teamRepository.getMyTeam(id: prefs.getInt('id')!).then((Either<Failure, TeamList> value) {
        value.fold((Failure l) async {
          emit(TeamListError(l.toString()));
        }, (TeamList r) async {
          myTeamList = r;
        });
      });
      emit(TeamListLoaded(myTeamList: myTeamList));
    });

    on<TeamEdit>((TeamEdit event, Emitter<TeamListState> emit) async {
      await _teamRepository.
      editTeam(team: event.team).
      then((Either<Failure, String> value) {
        value.fold((Failure l) async {
          emit(TeamListError(l.toString()));
        }, (String r) async {
          print(r);
        });
      });
    });

  }

  final SharedPreferences prefs = di.sl();

  final TeamRepositoryImpl _teamRepository;
}

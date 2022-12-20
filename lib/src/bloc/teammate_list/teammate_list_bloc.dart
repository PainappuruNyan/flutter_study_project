import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../core/error/failures.dart';
import '../../data/models/teammate_model.dart';
import '../../data/repositories/teammate_repository_impl.dart';
import '../../domain/entities/teammate_list.dart';

part 'teammate_list_event.dart';
part 'teammate_list_state.dart';

class TeammateListBloc extends Bloc<TeammateListEvent, TeammateListState> {
  TeammateListBloc(this._teammateRepository) : super(const TeammateListInitial()) {
    on<GetTeammateList>((GetTeammateList event,
        Emitter<TeammateListState> emit) async {
      emit(const TeammateListLoading());
      TeammateList teammateList = const TeammateList(teammates: []);
      await _teammateRepository.getTeammate(teamId: event.teamId).then((value) {
        value.fold((Failure l) async {
          emit(TeammateListError(l.toString()));
        }, (TeammateList r) async {
          teammateList = r;
        });
      });
      emit(TeammateListLoaded(teammateList: teammateList));
    });

    on<TeammateDelete>((TeammateDelete event, Emitter<TeammateListState> emit) async {
      await _teammateRepository
          .deleteTeammate(employeeId: event.employeeId, teamId: event.teamId)
          .then((Either<Failure, String> value) => GetTeammateList(teamId: event.teamId))
          .catchError(onError);
      emit(const TeammateListLoading());
      TeammateList teammateList = TeammateList(teammates: []);
      await _teammateRepository.getTeammate(teamId: event.teamId).then((Either<Failure, TeammateList> value) {
        value.fold((Failure l) async {
          emit(TeammateListError(l.toString()));
        }, (TeammateList r) async {
          teammateList = r;
        });
      });
      emit(TeammateListLoaded(teammateList: teammateList));
    });

    on<TeammateAdd>((TeammateAdd event, Emitter<TeammateListState> emit) async {
      await _teammateRepository
          .addTeammate(teammate: event.teammate)
          .catchError(onError);
    });
  }

    final TeammateRepositoryImpl _teammateRepository;
}

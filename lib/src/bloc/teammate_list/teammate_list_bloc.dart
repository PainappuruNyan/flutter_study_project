import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../core/error/failures.dart';
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
      await _teammateRepository.getTeammate(teamId: event.teamId).then((
          Either<Failure, TeammateList> value) {
        value.fold((Failure l) async {
          emit(TeammateListError(l.toString()));
        }, (TeammateList r) async {
          teammateList = r;
        });
      });

      emit(TeammateListLoaded(teammateList: teammateList));
    });
  }

    final TeammateRepositoryImpl _teammateRepository;
}

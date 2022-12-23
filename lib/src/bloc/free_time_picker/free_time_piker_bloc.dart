import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../data/models/time_interval_model.dart';
import '../../data/repositories/workplace_repository_impl.dart';
import '../../domain/entities/time_interval.dart';

import 'package:atb_first_project/dependency_injection_container.dart' as di;

import '../../domain/entities/time_interval_list.dart';

part 'free_time_piker_event.dart';

part 'free_time_piker_state.dart';

class FreeTimePikerBloc extends Bloc<FreeTimePikerEvent, FreeTimePikerState> {
  FreeTimePikerBloc() : super(FreeTimePikerInitial()) {
    on<FreeTimePikerEvent>((FreeTimePikerEvent event,
        Emitter<FreeTimePikerState> emit) {});
    on<DialogStarted>(_dialogStarted);
    on<TimeIntervalChanged>(_onIntervalChanged);
  }

  final WorkplaceRepositoryImpl _repositoryImpl = di.sl();

  FutureOr<void> _onIntervalChanged(TimeIntervalChanged event,
      Emitter<FreeTimePikerState> emit) {
    final List<TimeInterval> newIntervals = List<TimeInterval>.from(
        (state as FreeTimePikerLoaded).intervals);
    newIntervals[event.index] =
        TimeInterval(
            start: DateTime.fromMillisecondsSinceEpoch(
                event.start.toInt()),
            end: DateTime.fromMillisecondsSinceEpoch(
                event.end.toInt())
        );
    emit((state as FreeTimePikerLoaded).copyWith(intervals: newIntervals));
  }

  FutureOr<void> _dialogStarted(DialogStarted event,
      Emitter<FreeTimePikerState> emit) async {
    await _repositoryImpl.getFreeIntervals(event.placeId, event.date).then((
        Either<Failure, TimeIntervalList> value) =>
        value.fold(
                (Failure l) async {
                  print(l.toString());
                },
                (TimeIntervalList r) async {
                  print('success');
              emit(FreeTimePikerLoaded(
                  intervals: r.intervals, constIntervals: r.intervals));
            }
        )
    );
  }
}

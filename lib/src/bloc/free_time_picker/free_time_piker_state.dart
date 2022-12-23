part of 'free_time_piker_bloc.dart';

abstract class FreeTimePikerState extends Equatable {
  const FreeTimePikerState();
}

class FreeTimePikerInitial extends FreeTimePikerState {
  @override
  List<Object?> get props => [];
}

class FreeTimePikerLoaded extends FreeTimePikerState {
  const FreeTimePikerLoaded(
      {required this.intervals, required this.constIntervals});

  final List<TimeInterval> intervals;
  final List<TimeInterval> constIntervals;

  FreeTimePikerLoaded copyWith(
      {List<TimeInterval>? intervals,
      List<TimeInterval>? constIntervals}) {
    return FreeTimePikerLoaded(
        intervals: intervals ?? this.intervals,
        constIntervals: constIntervals ?? this.constIntervals);
  }

  @override
  List<Object> get props => [intervals, constIntervals];
}

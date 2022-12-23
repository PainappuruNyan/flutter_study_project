part of 'free_time_piker_bloc.dart';

abstract class FreeTimePikerEvent extends Equatable {
  const FreeTimePikerEvent();
}

class DialogStarted extends FreeTimePikerEvent {
  const DialogStarted({required this.placeId, required this.date});

  final int placeId;
  final DateTime date;

  @override
  List<Object?> get props => [];
}

class TimeIntervalChanged extends FreeTimePikerEvent {
  const TimeIntervalChanged(
      {required this.index, required this.start, required this.end});

  final int index;
  final double start;
  final double end;

  @override
  List<Object?> get props => [index, start, end];
}

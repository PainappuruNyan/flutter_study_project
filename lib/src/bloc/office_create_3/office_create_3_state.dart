part of 'office_create_3_bloc.dart';

abstract class OfficeCreate3State extends Equatable {
  const OfficeCreate3State();

  @override
  List<Object> get props => [];
}

class OfficeCreate3Initial extends OfficeCreate3State {
  const OfficeCreate3Initial({required this.officeId});


  final int officeId;

  @override
  List<Object> get props => [officeId];
}

class ScreenLoaded extends OfficeCreate3State {
  const ScreenLoaded({required this.floors});

  final List<MiniFloor> floors;

  @override
  List<Object> get props => [floors];
}

class ErrorState extends OfficeCreate3State{
  const ErrorState({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}





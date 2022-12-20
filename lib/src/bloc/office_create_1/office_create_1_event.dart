part of 'office_create_1_bloc.dart';

abstract class OfficeCreate1Event extends Equatable {
  const OfficeCreate1Event();

  @override
  List<Object?> get props => [];
}

class FieldChanged extends OfficeCreate1Event{
  const FieldChanged({required this.fieldChanged, required this.nText});
  final String? nText;
  final int fieldChanged;

  @override
  List<Object?> get props => [nText, fieldChanged];
}

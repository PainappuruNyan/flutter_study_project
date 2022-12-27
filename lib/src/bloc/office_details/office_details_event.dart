part of 'office_details_bloc.dart';

@immutable
abstract class OfficeDetailsEvent extends Equatable{
  const OfficeDetailsEvent();
}

class ShowBookingList extends OfficeDetailsEvent {
  const ShowBookingList({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}

class PostAdmin extends OfficeDetailsEvent {
  const PostAdmin(this.admin);

  final NewAdminModel admin;

  @override
  List<Object?> get props => [admin];
}

class OfficeDelete extends OfficeDetailsEvent{
  const OfficeDelete({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}

class OfficeEdit extends OfficeDetailsEvent{
  const OfficeEdit(this.office);

  final OfficeModel office;

  @override
  List<Object?> get props => [office];
}

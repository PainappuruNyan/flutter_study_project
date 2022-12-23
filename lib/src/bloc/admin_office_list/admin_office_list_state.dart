part of 'admin_office_list_bloc.dart';

abstract class AdminOfficeListState extends Equatable {
  const AdminOfficeListState();
}

class OfficeListLoading extends AdminOfficeListState {
  @override
  List<Object> get props => [];
}

class OfficeListLoaded extends AdminOfficeListState {

  const OfficeListLoaded({
    required this.offices,
    required this.cites,
  });

  final List<Office> offices;
  final List<String> cites;

  @override
  List<Object> get props => [offices, cites];
}
class OfficeListError extends AdminOfficeListState{

  @override
  List<Object> get props => [];
}

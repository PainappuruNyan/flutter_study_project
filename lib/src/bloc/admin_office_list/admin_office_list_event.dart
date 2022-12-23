part of 'admin_office_list_bloc.dart';



abstract class AdminOfficeListEvent extends Equatable {
  const AdminOfficeListEvent();
}

class AdminOfficeListStart extends AdminOfficeListEvent {
  @override
  List<Object?> get props => [];
}

class AdminOfficeListFavoriteChanged extends AdminOfficeListEvent{

  const AdminOfficeListFavoriteChanged({
    required this.id,
    required this.isFavorite
  });

  final int id;
  final bool isFavorite;

  @override
  List<Object?> get props => [id, isFavorite];
}

class AdminOfficeListOfficeSelected extends AdminOfficeListEvent{

  const AdminOfficeListOfficeSelected({
    required this.id
  });

  final int id;

  @override
  List<Object?> get props => [id];
}

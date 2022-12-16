part of 'user_list_bloc.dart';

@immutable
abstract class UserListEvent {}

class SearchUserEvent extends UserListEvent {

  SearchUserEvent(this.query, {this.startPage, this.currentPage});

  final String query;
  int? startPage;
  int? currentPage;
}

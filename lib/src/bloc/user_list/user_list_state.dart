part of 'user_list_bloc.dart';

class UserListState {
  const UserListState();

  @override
  List<Object?> get props => [];
}

class UserListInitial extends UserListState {
  const UserListInitial();

  @override
  List<Object?> get props => [];
}

class UserListLoading extends UserListState {
  const UserListLoading(this.oldUsers, {this.isFirstFetch = false});

  final List<Employee> oldUsers;
  final bool isFirstFetch;

  @override
  List<Object?> get props => [];
}

class UserListLoaded extends UserListState {
  const UserListLoaded({this.users = const <Employee>[]});
  final List<Employee> users;

  @override
  List<Object?> get props => [users];
}

class UserListSearched extends UserListState {
  const UserListSearched({this.users = const <Employee>[]});
  final List<Employee> users;

  @override
  List<Object?> get props => [users];
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../core/error/failures.dart';
import '../../data/repositories/employee_list_repository_impl.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/employee_list.dart';

part 'user_list_event.dart';

part 'user_list_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (Stream<E> events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc(this._employeeListRepository) : super(const UserListState()) {
    on<SearchUserEvent>(_onSearch,
        transformer: debounceDroppable(
          const Duration(milliseconds: 100),
        ));
  }

  final EmployeeListRepositoryImpl _employeeListRepository;
  int page = 0;
  String searchQ = '';

  Future<void> _onSearch(
      SearchUserEvent event, Emitter<UserListState> emit) async {
    if (event.query.length < 3) return;
    List<Employee> allUsers = <Employee>[];
    if (searchQ != event.query) {
      page = 0;
      allUsers.clear();
      searchQ = event.query;
      emit(UserListLoaded(users: allUsers));
    }
    if (state is UserListLoading) {
      return;
    }

    final UserListState currentState = state;

    List<Employee> oldUsers = <Employee>[];
    if (currentState is UserListLoaded) {
      oldUsers = currentState.users;
    }

    emit(UserListLoading(oldUsers, isFirstFetch: page == 0));

    await _employeeListRepository
        .getEmployeeByName(event.query, page)
        .then((Either<Failure, EmployeeList> value) {
      value.fold((Failure l) async {}, (EmployeeList r) async {
        allUsers = (state as UserListLoading).oldUsers;
        allUsers.addAll(r.employees);
        page++;
      });
      emit(UserListLoaded(users: allUsers));
    });
  }
}

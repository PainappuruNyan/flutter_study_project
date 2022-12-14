import 'dart:async';

import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/failures.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/profile.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginExecute>(_onExecute);
    on<LoginFormLoaded>((event, emit) {});
  }

  late ProfileRepositoryImpl profileRepositoryImpl;
  final SharedPreferences pref = di.sl();

  Future<void> _onExecute(LoginExecute event, Emitter<LoginState> emit) async {
    emit(LoginExecuting(event.username, event.password));
    profileRepositoryImpl = di.sl<ProfileRepositoryImpl>();
    if (event.username == null || event.password == null) {
      emit(const LoginLocalError('Введите все поля формы'));
    } else if(event.username != '' && event.password != ''){
      await profileRepositoryImpl
          .getProfileByCredits(event.username!, event.password!)
          .then((Either<Failure, Profile> value) {
        value.fold((Failure l) async {
          emit(LoginRemoteError(l.toString()));
        }, (Profile r) async {
          print('провиль получили. Успех');
          pref.setString('role', r.employee.role);
          emit(LoginSuccess(r));
        });
      });
    } else{
      emit(const LoginLocalError('Заполните все поля формы'));
    }
  }
}

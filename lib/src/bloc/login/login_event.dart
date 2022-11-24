part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginFormLoaded extends LoginEvent {
  const LoginFormLoaded();
}

class UsernameChanged extends LoginEvent {
  const UsernameChanged(this.username);

  final String? username;

}

class PasswordChanged extends LoginEvent {
  const PasswordChanged(this.password);

  final String? password;
}

class LoginExecute extends LoginEvent {
  const LoginExecute(this.username, this.password);

  final String? username;
  final String? password;

  @override
  List<Object?> get props => [username, password];
}


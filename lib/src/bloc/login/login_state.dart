part of 'login_bloc.dart';

abstract class LoginState extends Equatable{
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState{}

class LoginExecuting extends LoginState{
  const LoginExecuting(
      this.username,
      this.password
  );

  final String? username;
  final String? password;

  @override
  List<Object?> get props => [username, password];
}

class LoginLocalError extends LoginState{
  const LoginLocalError(this.errorMessage);
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

class LoginRemoteError extends LoginState{
  const LoginRemoteError(this.errorMessage);
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

class LoginSuccess extends LoginState{
  const LoginSuccess(this.profile);
  final Profile profile;

  @override
  List<Object?> get props => [profile];
}



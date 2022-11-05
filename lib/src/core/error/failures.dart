import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  const Failure([List properties = const<dynamic>[]]);
}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCasheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

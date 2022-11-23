part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileStarted extends ProfileEvent{
  @override
  List<Object?> get props => [];
}

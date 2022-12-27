part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackState extends Equatable {
  const FeedbackState();
}

class FeedbackInitial extends FeedbackState {
  @override
  List<Object> get props => [];
}

class FeedbackLoading extends FeedbackState {
  @override
  List<Object> get props => [];
}

class FeedbackSuccess extends FeedbackState {
  const FeedbackSuccess();

  @override
  List<Object> get props => [];
}

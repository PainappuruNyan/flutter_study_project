part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class FeedbackPost extends FeedbackEvent {
  const FeedbackPost({required this.feedback});

  final UserFeedbackModel feedback;
}

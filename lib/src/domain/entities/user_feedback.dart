import 'package:equatable/equatable.dart';

class UserFeedback extends Equatable{
  const UserFeedback({
    required this.title,
    required this.text,
  });

  final String title;
  final String text;
  @override
  List<Object> get props => [title, text];
}
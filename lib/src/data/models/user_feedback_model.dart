import '../../domain/entities/user_feedback.dart';

class UserFeedbackModel extends UserFeedback{
  const UserFeedbackModel({required super.title, required super.text});

  factory UserFeedbackModel.fromJson(Map<String, dynamic> json){
    return UserFeedbackModel(
      title: json['title'] as String,
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'text': text,
    };
  }
}
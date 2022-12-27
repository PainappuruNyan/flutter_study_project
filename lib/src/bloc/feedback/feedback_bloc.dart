import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:atb_first_project/dependency_injection_container.dart' as di;

import '../../core/error/failures.dart';
import '../../data/models/user_feedback_model.dart';
import '../../data/repositories/user_feedback_repository_impl.dart';

part 'feedback_event.dart';

part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial()) {
    on<FeedbackPost>(_onPost);
  }

  Future<void> _onPost(FeedbackPost event, Emitter<FeedbackState> emit) async {
    final UserFeedbackRepositoryImpl _repository = di.sl();
    emit (FeedbackLoading());

    await _repository
        .postFeedback(feedback: event.feedback)
        .then((Either<Failure, String> value) {
      value.fold((Failure l) => print(l.toString()), (String r) async {
        emit(const FeedbackSuccess());
      });
    });
  }
}

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/models/user_feedback_model.dart';

abstract class UserFeedbackRepository{
  Future<Either<Failure, String>> postFeedback({required UserFeedbackModel feedback});
}
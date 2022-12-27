import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/repository/user_feedback_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/user_feedback_model.dart';

class UserFeedbackRepositoryImpl implements UserFeedbackRepository {
  UserFeedbackRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, String>> postFeedback({required UserFeedbackModel feedback}) async {
    try {
      final String successString =
      await remoteDataSource.postFeedback(feedback: feedback);
      return Right(successString);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
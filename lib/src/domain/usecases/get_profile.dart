import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/profile.dart';
import '../repository/profile_repository.dart';

class GetProfile{
  GetProfile(this.repository);
  final ProfileRepository repository;

  Future<Either<Failure, Profile>> execute({
    required String login
  }) async {
    return await repository.getProfile();
  }
}

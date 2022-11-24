import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/profile.dart';

abstract class ProfileRepository{
  Future<Either<Failure, Profile>> getProfile();
  Future<Either<Failure, Profile>> getProfileByCredits(String username, String password);
}

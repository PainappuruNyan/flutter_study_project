import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/models/booking_model.dart';
import '../entities/booking_list.dart';

abstract class BookingListRepository {
  Future<Either<Failure, BookingList>> getAllActual();

  Future<Either<Failure, BookingList>> getAllSelf();

  Future<Either<Failure, String>> postBooking({required BookingModel booking});

  Future<Either<Failure, String>> editBooking({required BookingModel booking});

  Future<Either<Failure, BookingList>> getOfficeBooking(
      int officeId, int type, bool isActual, int page);
}

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/booking_list.dart';

abstract class BookingListRepository{
  Future<Either<Failure, BookingList>> getAllActual();
  Future<Either<Failure, BookingList>> getAllSelf();
}

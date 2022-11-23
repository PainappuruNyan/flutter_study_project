// import 'dart:math';

import '../../domain/entities/booking_test.dart';

abstract class BookingRepository {
  /// Throws [NetworkException].
  Future<List<BookingTest>> fetchActualBooking();

  Future<List<BookingTest>> fetchHistoryBooking();
}

class FakeBookingRepository implements BookingRepository {
  @override
  Future<List<BookingTest>> fetchActualBooking() {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        // final random = Random();
        //
        // if (random.nextBool()) {
        //   throw NetworkException();
        // }

        return [
          const BookingTest(
              bookingId: 1,
              address: 'address',
              place: 'work place',
              placeId: 1),
          const BookingTest(
              bookingId: 2,
              address: 'address',
              place: 'work place',
              placeId: 2),
        ];
      },
    );
  }

  @override
  Future<List<BookingTest>> fetchHistoryBooking() {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        // final random = Random();
        //
        // if (random.nextBool()) {
        //   throw NetworkException();
        // }

        return [
          const BookingTest(
              bookingId: 3,
              address: 'address',
              place: 'work place',
              placeId: 3),
          const BookingTest(
              bookingId: 4,
              address: 'address',
              place: 'work place',
              placeId: 4),
        ];
      },
    );
  }
}

class NetworkException implements Exception {}

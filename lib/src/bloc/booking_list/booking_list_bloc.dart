import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../core/error/failures.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../../domain/entities/booking_list.dart';

part 'booking_list_event.dart';

part 'booking_list_state.dart';

class BookingListBloc extends Bloc<BookingListEvent, BookingListState> {


  BookingListBloc(this._bookingRepository, this.isOfficeBooking, this.officeId)
      : super(const BookingListInitial()) {
    on<GetBookingList>(
            (GetBookingList event, Emitter<BookingListState> emit) async {
          emit(const BookingListLoading());
          BookingList bookingListActual = const BookingList(bookings: []);

          if (isOfficeBooking) {
            await _bookingRepository.getOfficeBooking(officeId!, 1, true, 0)
                .then((Either<Failure, BookingList> value) => value.fold(
                    (Failure l) {
                      emit(BookingListError(l.toString()));
                    },
                    (BookingList r) {
                      bookingListActual = r;
                    }
            ));
          }
          else {
            await _bookingRepository
                .getAllActual()
                .then((Either<Failure, BookingList> value) {
              value.fold((Failure l) async {
                emit(BookingListError(l.toString()));
              }, (BookingList r) async {
                bookingListActual = r;
              });
            });
          }


          BookingList bookingHistory = const BookingList(bookings: []);

          if (isOfficeBooking) {
            await _bookingRepository.getOfficeBooking(officeId!, 2, true, 0)
                .then((Either<Failure, BookingList> value) => value.fold(
                    (Failure l) {
                      emit(BookingListError(l.toString()));
                },
                    (BookingList r) {
                      bookingHistory = r;
                }
            ));
          } else {
            await _bookingRepository
                .getAllSelf()
                .then((Either<Failure, BookingList> value) {
              value.fold((Failure l) async {
                emit(BookingListError(l.toString()));
              }, (BookingList r) async {
                bookingHistory = r;
              });
            });
          }

          emit(BookingListLoaded(
              bookingListActual: bookingListActual,
              bookingListHistory: bookingHistory));
        });

    on<BookingDelete>((BookingDelete event,
        Emitter<BookingListState> emit) async {
      emit(const BookingListLoading());
      await _bookingRepository
          .deleteBooking(id: event.id)
          .then((Either<Failure, String> value) => const GetBookingList())
          .catchError(onError);
      BookingList bookingListActual = const BookingList(bookings: []);
      await _bookingRepository.getAllActual().then((
          Either<Failure, BookingList> value) {
        value.fold((Failure l) async {
          emit(BookingListError(l.toString()));
        }, (BookingList r) async {
          bookingListActual = r;
        });
      });

      BookingList bookingListHistory = const BookingList(bookings: []);
      await _bookingRepository
          .getAllActual()
          .then((Either<Failure, BookingList> value) {
        value.fold((Failure l) async {
          emit(BookingListError(l.toString()));
        }, (BookingList r) async {
          bookingListHistory = r;
        });
      });
      emit(BookingListLoaded(bookingListActual: bookingListActual,
          bookingListHistory: bookingListHistory));
    });
  }

  final BookingRepositoryImpl _bookingRepository;
  final bool isOfficeBooking;
  final int? officeId;

}

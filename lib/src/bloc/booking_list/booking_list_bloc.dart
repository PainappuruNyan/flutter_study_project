import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/booking_repository_test.dart';
import '../../domain/entities/booking_test.dart';

part 'booking_list_event.dart';
part 'booking_list_state.dart';

class BookingListBloc extends Bloc<BookingListEvent, BookingListState> {

  BookingListBloc(this._bookingRepository): super(const BookingListInitial()) {
    on<GetBookingList>((GetBookingList event, Emitter<BookingListState> emit) async {
      emit(const BookingListLoading());
      try {
        final List<BookingTest> bookingActual = await _bookingRepository.fetchActualBooking();
        final List<BookingTest> bookingHistory = await _bookingRepository.fetchHistoryBooking();
        emit(BookingListLoaded(BookingListTest(BookingActual: bookingActual, BookingHistory: bookingHistory)));
      }
      catch (e) {
        emit (BookingListError(e.toString()));
      }
    });
  }
  final FakeBookingRepository _bookingRepository;

  // Stream<BookingListState> mapEventToState(
  //     BookingListEvent event,
  //     ) async* {
  //   if (event is GetBookingList) {
  //     try {
  //       yield const BookingListLoading();
  //       final List<Booking> booking = await _bookingRepository.fetchBooking(event.bookingId);
  //       yield BookingListLoaded(booking);
  //     } on NetworkException {
  //       yield const BookingListError("Couldn't fetch booking. Is the device online?");
  //     }
  //   }
  // }
}

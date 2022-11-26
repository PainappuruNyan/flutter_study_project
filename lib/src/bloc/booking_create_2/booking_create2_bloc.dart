import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'booking_create2_event.dart';
part 'booking_create2_state.dart';

class BookingCreate2Bloc extends Bloc<BookingCreate2Event, BookingCreate2State> {
  BookingCreate2Bloc() : super(BookingCreate2Loading()) {
    on<BookingCreate2Start>(_onStart);
    on<BookingCreate2DatetimeSelected>(_onDatetimeSelected);
  }

  void _onStart(BookingCreate2Event event, Emitter<BookingCreate2State> emit) {
    emit(BookingCreate2Loaded());
  }

  void _onDatetimeSelected(BookingCreate2Event event, Emitter<BookingCreate2State> emit) {
  }

}

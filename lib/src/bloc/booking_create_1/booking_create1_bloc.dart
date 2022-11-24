import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/office.dart';

part 'booking_create1_event.dart';
part 'booking_create1_state.dart';

class BookingCreate1Bloc extends Bloc<BookingCreate1Event, BookingCreate1State> {
  BookingCreate1Bloc() : super(BookingCreate1Loading()) {
    on<BookingCreate1Start>(_onStart);
    on<BookingCreate1FavoriteChanged>(_onFavoriteChanged);
    on<BookingCreate1OfficeSelected>(_onOfficeSelected);
  }

  FutureOr<void> _onStart(BookingCreate1Start event, Emitter<BookingCreate1State> emit) {
  }

  FutureOr<void> _onFavoriteChanged(BookingCreate1FavoriteChanged event, Emitter<BookingCreate1State> emit) {
  }

  FutureOr<void> _onOfficeSelected(BookingCreate1OfficeSelected event, Emitter<BookingCreate1State> emit) {
  }
}

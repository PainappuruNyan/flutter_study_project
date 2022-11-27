import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/office.dart';

part 'booking_create1_event.dart';
part 'booking_create1_state.dart';

class BookingCreate1Bloc extends Bloc<BookingCreate1Event, BookingCreate1State> {
  BookingCreate1Bloc() : super(BookingCreate1Loading()) {
    on<BookingCreate1Start>(_onStart);
    on<BookingCreate1FavoriteChanged>(_onFavoriteChanged);
    on<BookingCreate1OfficeSelected>(_onOfficeSelected);
  }

  // final OfficeRepositoryImpl officeRepositoryImpl = di.sl();

  Future<void> _onStart(BookingCreate1Start event, Emitter<BookingCreate1State> emit) async {
    // await officeRepositoryImpl.getOffices().then((Either<Failure, OfficeList> value) {
    //   value.fold((Failure l) async {
    //     emit(BookingCreate1Error());
    //   }, (OfficeList r) async {
    //     emit(BookingCreate1Loaded(offices: r.offices, cites: const <String>['Владивосток']));
    //   });
    // });
    List<Office> offices = <Office>[
      Office(
          id: 1,
          address: 'Океанская 12д',
          bookingRange: 7,
          cityName: 'Владивосток',
          workNumber: '8-800-775-88-88',
          startOfDay: DateFormat('HH:mm').parse("08:00"),
          endOfDay: DateFormat('HH:mm').parse("19:00")),
      Office(
          id: 1,
          address: 'Шепеткова 8д',
          bookingRange: 7,
          cityName: 'Владивосток',
          workNumber: '8-800-775-88-88',
          startOfDay: DateFormat('HH:mm').parse("08:00"),
          endOfDay: DateFormat('HH:mm').parse("19:00")),
      Office(
          id: 1,
          address: 'Краснофлотская 135',
          bookingRange: 7,
          cityName: 'Благовещенск',
          workNumber: '8-800-100-24-24',
          startOfDay: DateFormat('HH:mm').parse("08:00"),
          endOfDay: DateFormat('HH:mm').parse("19:00")),
      Office(
          id: 1,
          address: 'Красноармейская 123',
          bookingRange: 7,
          cityName: 'Благовещенск',
          workNumber: '8-800-100-24-24',
          startOfDay: DateFormat('HH:mm').parse("08:00"),
          endOfDay: DateFormat('HH:mm').parse("19:00")),
    ];
    List<String> cites = <String>[
      'Избранное',
      'Владивосток',
      'Благовещенск',
    ];
    List<Office> favorites = <Office>[
      Office(
          id: 1,
          address: 'Океанская 12д',
          bookingRange: 7,
          cityName: 'Владивосток',
          workNumber: '9-900-900-90-90',
          startOfDay: DateFormat('HH:mm').parse("08:00"),
          endOfDay: DateFormat('HH:mm').parse("19:00")),
      Office(
          id: 1,
          address: 'Краснофлотская 135',
          bookingRange: 7,
          cityName: 'Благовещенск',
          workNumber: '9-900-900-90-90',
          startOfDay: DateFormat('HH:mm').parse("08:00"),
          endOfDay: DateFormat('HH:mm').parse("19:00")),
    ];
    emit(BookingCreate1Loaded(offices: offices, cites: cites, favorites: favorites));

  }

  FutureOr<void> _onFavoriteChanged(BookingCreate1FavoriteChanged event, Emitter<BookingCreate1State> emit) {
  }

  FutureOr<void> _onOfficeSelected(BookingCreate1OfficeSelected event, Emitter<BookingCreate1State> emit) {
  }
}

import 'dart:async';

import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../data/repositories/office_repository_impl.dart';
import '../../domain/entities/office.dart';
import '../../domain/entities/office_list_.dart';

part 'booking_create1_event.dart';
part 'booking_create1_state.dart';

class BookingCreate1Bloc extends Bloc<BookingCreate1Event, BookingCreate1State> {
  BookingCreate1Bloc() : super(BookingCreate1Loading()) {
    on<BookingCreate1Start>(_onStart);
    on<BookingCreate1FavoriteChanged>(_onFavoriteChanged);
    on<BookingCreate1OfficeSelected>(_onOfficeSelected);
  }

  final OfficeRepositoryImpl officeRepositoryImpl = di.sl();

  Future<void> _onStart(BookingCreate1Start event, Emitter<BookingCreate1State> emit) async {
    List<String> cites = [];
    await officeRepositoryImpl.getCites().then((value) => value.fold((l) => null, (r) => cites = r.cites.map((e) => e.name).toList()));
    await officeRepositoryImpl.getOffices().then((Either<Failure, OfficeList> value) {
      value.fold((Failure l) async {
        emit(BookingCreate1Error());
      }, (OfficeList r) async {
        if (r.offices.any((element) => element.isFavorite == true)){
          cites.insert(0, 'Избранное');
        }
        emit(BookingCreate1Loaded(offices: r.offices, cites: cites));
      });
    });
  }

  FutureOr<void> _onFavoriteChanged(BookingCreate1FavoriteChanged event, Emitter<BookingCreate1State> emit) async {
    await officeRepositoryImpl.changeFavorite(event.id, event.isFavorite).then((value) {
      add(BookingCreate1Start());
    });
  }

  FutureOr<void> _onOfficeSelected(BookingCreate1OfficeSelected event, Emitter<BookingCreate1State> emit) {
  }
}

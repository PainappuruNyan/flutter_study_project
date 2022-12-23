import 'dart:async';

import 'package:atb_first_project/dependency_injection_container.dart' as di;
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/failures.dart';
import '../../data/models/office_model.dart';
import '../../data/repositories/office_repository_impl.dart';
import '../../domain/entities/city.dart';
import '../../domain/entities/city_list.dart';
import '../../domain/entities/office.dart';

part 'office_create_1_event.dart';

part 'office_create_1_state.dart';

class OfficeCreate1Bloc extends Bloc<OfficeCreate1Event, OfficeCreate1State> {
  OfficeCreate1Bloc() : super(StartingState()) {
    on<Starting>(
        (OfficeCreate1Event event, Emitter<OfficeCreate1State> emit) async {
      print('начало');
      await repository.getCites().then((Either<Failure, CityList> value) =>
          value.fold(
              (Failure l) => {print('Города не получены ${l.toString()}')},
              (CityList r) {
            cityList = r.cites;
            print('Телефон: ${prefs.getString('phoneNumber')}');
            emit(OfficeCreate1Initial(
                phoneNumber: prefs.getString('phoneNumber')));
          }));
    });
    on<FieldChanged>(_onFieldChanged);
    on<ConfirmCreation>(_onConfirmCreation);
  }

  OfficeRepositoryImpl repository = di.sl();
  SharedPreferences prefs = di.sl();
  List<City> cityList = [];

  FutureOr<void> _onFieldChanged(
      FieldChanged event, Emitter<OfficeCreate1State> emit) {
    if (state is OfficeCreate1Initial) {
      switch (event.fieldChanged) {
        case 1:
          {
            //изменилось стартовое время
            emit((state as OfficeCreate1Initial)
                .copyWith(beginningTime: event.nText));
            break;
          }
        case 2:
          {
            //изменилось конечное время
            emit(
                (state as OfficeCreate1Initial).copyWith(endTime: event.nText));
            break;
          }
        case 3:
          {
            //изменился диапазон брони
            if (event.nText!.isEmpty) {
              emit((state as OfficeCreate1Initial).copyWith(bookingRange: 0));
            } else {
              emit((state as OfficeCreate1Initial)
                  .copyWith(bookingRange: int.parse(event.nText!)));
            }
            break;
          }
        case 4:
          {
            //изменилось количество этажей
            if (event.nText!.isEmpty) {
              emit((state as OfficeCreate1Initial).copyWith(floorsCount: 0));
            } else {
              emit((state as OfficeCreate1Initial)
                  .copyWith(floorsCount: int.parse(event.nText!)));
            }
            break;
          }
        case 5:
          {
            //изменился город

            emit((state as OfficeCreate1Initial).copyWith(
                city: event.nText!.split(' ')[0],
                cityId: int.parse(event.nText!.split(' ')[1])));
            break;
          }
        case 6:
          {
            print('Адрес изменился');
            //изменился адресс
            emit(
                (state as OfficeCreate1Initial).copyWith(address: event.nText));
            break;
          }
      }
    }
  }

  FutureOr<void> _onConfirmCreation(
      ConfirmCreation event, Emitter<OfficeCreate1State> emit) async {
    await repository.postOffice(OfficeModel.fromOffice(event.office)).then(
        (Either<Failure, String> value) =>
            value.fold((Failure l) => print(l.toString()), (String r) {
              print(r);
              emit(OfficeCreated());
            }));
  }
}

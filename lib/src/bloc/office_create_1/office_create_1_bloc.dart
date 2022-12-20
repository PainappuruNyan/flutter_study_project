import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../data/models/office_model.dart';

part 'office_create_1_event.dart';

part 'office_create_1_state.dart';

class OfficeCreate1Bloc extends Bloc<OfficeCreate1Event, OfficeCreate1State> {
  OfficeCreate1Bloc()
      : super(OfficeCreate1Initial()) {
    on<OfficeCreate1Event>((OfficeCreate1Event event, Emitter<OfficeCreate1State> emit) {});
    on<FieldChanged>(_onFieldChanged);
  }

  FutureOr<void> _onFieldChanged(FieldChanged event, Emitter<OfficeCreate1State> emit) {
    if(state is OfficeCreate1Initial){
      switch (event.fieldChanged){
        case 1:{
          //изменилось стартовое время
          emit((state as OfficeCreate1Initial).copyWith(beginningTime: event.nText));
          break;
        }
        case 2:{
          //изменилось конечное время
          emit((state as OfficeCreate1Initial).copyWith(endTime: event.nText));
          break;
        }
        case 3:{
          //изменился диапазон брони
          emit((state as OfficeCreate1Initial).copyWith(bookingRange: int.parse(event.nText!)));
          break;
        }
        case 4:{
          //изменилось количество этажей
          emit((state as OfficeCreate1Initial).copyWith(floorsCount: int.parse(event.nText!)));
          break;
        }
        case 5:{
          //изменился город
          emit((state as OfficeCreate1Initial).copyWith(city: event.nText));
          break;
        }
        case 6:{
          //изменился адресс
          emit((state as OfficeCreate1Initial).copyWith(address: event.nText));
          break;
        }
      }
    }

  }
}

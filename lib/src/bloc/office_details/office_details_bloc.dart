import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../core/error/failures.dart';
import '../../data/models/new_admin_model.dart';
import '../../data/models/office_model.dart';
import '../../data/repositories/administration_repository_impl.dart';
import '../../domain/entities/booking_list.dart';

part 'office_details_event.dart';
part 'office_details_state.dart';

class OfficeDetailsBloc extends Bloc<OfficeDetailsEvent, OfficeDetailsState> {
  OfficeDetailsBloc(this._repository) : super(const OfficeDetailsInitial()) {

    on<OfficeDelete>(
        (OfficeDelete event, Emitter<OfficeDetailsState> emit) async {
          emit(const OfficeDetailsLoading());
      await _repository
          .deleteOffice(event.id)
          .then((Either<Failure, String> value) {
        value.fold((Failure l) async {
          print(l.toString());
        }, (String r) async {
          print(r);
        });
      });
      emit(const OfficeDetailsSuccess());
    });

    on<PostAdmin>(
            (PostAdmin event, Emitter<OfficeDetailsState> emit) async {
              emit(const OfficeDetailsLoading());
          await _repository
              .postAdmin(event.admin)
              .then((Either<Failure, String> value) {
            value.fold((Failure l) async {
              print(l.toString());
            }, (String r) async {
              print(r);
            });
          });
          emit(const OfficeDetailsSuccess());
        });

    on<OfficeEdit>(
            (OfficeEdit event, Emitter<OfficeDetailsState> emit) async {
          emit(const OfficeDetailsLoading());
          await _repository
              .editOffice(event.office)
              .then((Either<Failure, String> value) {
            value.fold((Failure l) async {
              print(l.toString());
            }, (String r) async {
              print(r);
            });
          });
          emit(const OfficeDetailsSuccess());
        });
  }

  final AdministrationRepositoryImpl _repository;
}

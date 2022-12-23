import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../data/repositories/office_repository_impl.dart';
import '../../domain/entities/office.dart';

import 'package:atb_first_project/dependency_injection_container.dart' as di;

import '../../domain/entities/office_list_.dart';

part 'admin_office_list_event.dart';
part 'admin_office_list_state.dart';

class AdminOfficeListBloc extends Bloc<AdminOfficeListEvent, AdminOfficeListState> {
  AdminOfficeListBloc() : super(OfficeListLoading()) {
    on<AdminOfficeListStart>(_onStart);
    on<AdminOfficeListFavoriteChanged>(_onFavoriteChanged);
    on<AdminOfficeListOfficeSelected>(_onOfficeSelected);
  }

  final OfficeRepositoryImpl officeRepositoryImpl = di.sl();

  FutureOr<void> _onStart(AdminOfficeListStart event, Emitter<AdminOfficeListState> emit) async {
    List<String> cites = [];
    await officeRepositoryImpl.getCites().then((value) => value.fold((l) => null, (r) => cites = r.cites.map((e) => e.name).toList()));
    await officeRepositoryImpl.getOffices().then((Either<Failure, OfficeList> value) {
      value.fold((Failure l) async {
        emit(OfficeListError());
      }, (OfficeList r) async {
        if (r.offices.any((element) => element.isFavorite == true)){
          cites.insert(0, 'Избранное');
        }
        emit(OfficeListLoaded(offices: r.offices, cites: cites));
      });
    });
  }

  FutureOr<void> _onFavoriteChanged(AdminOfficeListFavoriteChanged event, Emitter<AdminOfficeListState> emit) {
  }

  FutureOr<void> _onOfficeSelected(AdminOfficeListOfficeSelected event, Emitter<AdminOfficeListState> emit) {
  }
}

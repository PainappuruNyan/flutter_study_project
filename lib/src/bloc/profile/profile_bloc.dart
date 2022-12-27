import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../data/datasources/remote_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/profile.dart';
import 'package:atb_first_project/dependency_injection_container.dart' as di;

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(ProfileLoading())  {
    on<ProfileStarted>(_onStarted);
  }

  late ProfileRepositoryImpl profileRepositoryImpl;
  SharedPreferences prefs = di.sl();
  int get userId {
   return prefs.getInt('id')!;
  }

  Future<void> _onStarted(
      ProfileStarted event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    profileRepositoryImpl = ProfileRepositoryImpl(
        networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
        remoteDataSource: RemoteImplWithHttp(client: Client()),);
    await profileRepositoryImpl
        .getProfile()
        .then((Either<Failure, Profile> value) {
          value.fold(
                  (Failure l) async {
                    emit(ProfileError());
                  },
                  (Profile r) async {
                    prefs.setString('login', r.employee.login);
                    prefs.setString('role', r.employee.roleString);
                    prefs.setInt('id', r.employee.id);
                    prefs.setString('phoneNumber', r.employee.phoneNumber);
                    prefs.setString('fullName', r.employee.fullName);
                    r.employee.imageId!=null ? prefs.setInt('imageId', r.employee.imageId!) : prefs.containsKey('imageId') ? prefs.remove('imageId') : null;
                    print(prefs.getString('phoneNumber'));
                    emit(ProfileLoaded(r));
                  }
          );
    });
    // emit(ProfileLoaded(employee));
  }
}

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/core/network/network_info.dart';
import 'src/data/datasources/remote_data_source.dart';
import 'src/data/repositories/booking_repository_impl.dart';
import 'src/data/repositories/office_repository_impl.dart';
import 'src/data/repositories/profile_repository_impl.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async{

  sl.registerLazySingleton<ProfileRepositoryImpl>(() => ProfileRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteImplWithHttp(client: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => http.Client());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => BookingRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton(() => OfficeRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

}

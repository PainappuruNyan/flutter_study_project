import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/booking_list.dart';
import '../../domain/entities/office_list_.dart';
import '../../domain/repository/booking_list_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/booking_list_model.dart';
import '../models/office_list_model.dart';


class BookingRepositoryImpl implements BookingListRepository{
  BookingRepositoryImpl( {
    required this.networkInfo,
    required this.remoteDataSource,
  });
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;



  @override
  Future<Either<Failure, OfficeList>> getOffices() async {
    try{
      final OfficeListModel remoteOffices = await remoteDataSource.getOffices();
      return Right(remoteOffices);
    }
    on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BookingList>> getAllActual() async {
    try{
      final BookingListModel remoteActualBookings = await remoteDataSource.getAllActual();
      return Right(remoteActualBookings);
    }
    on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BookingList>> getAllSelf() async {
    try{
      final BookingListModel remoteSelfBookings = await remoteDataSource.getAllSelf();
      return Right(remoteSelfBookings);
    }
    on ServerException {
      return Left(ServerFailure());
    }
  }
}

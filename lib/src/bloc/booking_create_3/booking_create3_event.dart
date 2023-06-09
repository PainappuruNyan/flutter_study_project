part of 'booking_create3_bloc.dart';

abstract class BookingCreate3Event extends Equatable {
  const BookingCreate3Event();

  @override
  List<Object> get props => [];
}

class BookingCreate3Start extends BookingCreate3Event{}

class BookingCreate3ChangeToMap extends BookingCreate3Event{}

class BookingCreate3ChangeToList extends BookingCreate3Event{}

class BookingCreate3FavoriteChanged extends BookingCreate3Event{
  const BookingCreate3FavoriteChanged({required this.workplaceId, required this.isFavorite});

  final int workplaceId;
  final bool isFavorite;

  @override
  List<Object> get props => [workplaceId, isFavorite];
}

class BookingCreate3ChangeFloor extends BookingCreate3Event{
  const BookingCreate3ChangeFloor({required this.floorNumber});

  final int floorNumber;

  @override
  List<Object> get props => [floorNumber];
}

class BookingCreate3WorkplaceSelected extends BookingCreate3Event{
  const BookingCreate3WorkplaceSelected( {required this.booking, required this.employeeId,});

  final int employeeId;
  final BookingModel booking;
}

class BookingCreate3SendWorkplaces extends BookingCreate3Event{
}

class BookingCreate3RemoveWorkplace extends BookingCreate3Event{
  const BookingCreate3RemoveWorkplace({required this.bookingForRemove});

  final Booking bookingForRemove;

  @override
  List<Object> get props => [bookingForRemove];
}

class ChangeSelectedEmployee extends BookingCreate3Event{
  const ChangeSelectedEmployee({required this.nSelectedId});

  final int nSelectedId;

  @override
  List<Object> get props => [nSelectedId];
}

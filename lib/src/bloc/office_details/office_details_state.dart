part of 'office_details_bloc.dart';

@immutable
abstract class OfficeDetailsState extends Equatable {
  const OfficeDetailsState();
}

class OfficeDetailsInitial extends OfficeDetailsState {
  const OfficeDetailsInitial();

  @override
  List<Object?> get props => [];
}

class ShowBookingListLoaded extends OfficeDetailsState {
  const ShowBookingListLoaded({required this.bookingList});

  final List<BookingList> bookingList;

  @override
  List<Object?> get props => [id];
}

class OfficeDetailsLoading extends OfficeDetailsState {
  const OfficeDetailsLoading();

  @override
  List<Object?> get props => [];
}

class OfficeDetailsSuccess extends OfficeDetailsState {
  const OfficeDetailsSuccess();

  @override
  List<Object?> get props => [];
}

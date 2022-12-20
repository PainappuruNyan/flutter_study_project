part of 'office_create_1_bloc.dart';

abstract class OfficeCreate1State extends Equatable {
  const OfficeCreate1State();
}

class OfficeCreate1Initial extends OfficeCreate1State {
  OfficeCreate1Initial({
      String beginningTimeText = '08:00',
      String endTimeText = '21:00',
      this.bookingRange = 7,
      this.floorsCount = 1,
      this.city = '',
      this.address = ''}) {
    beginningTime = DateFormat('HH:mm').parse(beginningTimeText);
    endTime = DateFormat('HH:mm').parse(endTimeText);
    nOffice = OfficeModel(
        id: null,
        cityName: city,
        address: address,
        startOfDay: beginningTime,
        endOfDay: endTime,
        bookingRange: bookingRange,
        workNumber: '',
        isFavorite: null);
  }

  late final DateTime beginningTime;
  late final DateTime endTime;
  final int bookingRange;
  final int floorsCount;
  final String city;
  final String address;
  late final OfficeModel nOffice;

  OfficeCreate1Initial copyWith({
    String? beginningTime,
    String? endTime,
    int? bookingRange,
    int? floorsCount,
    String? city,
    String? address,
  }) {
    return OfficeCreate1Initial(
        beginningTimeText: beginningTime ?? DateFormat('HH:mm').format(this.beginningTime),
        endTimeText: endTime ??  DateFormat('HH:mm').format(this.endTime),
        bookingRange: bookingRange ?? this.bookingRange,
        floorsCount: floorsCount ?? this.floorsCount,
        city: city ?? this.city,
        address: address ?? this.address);
  }

  @override
  List<Object> get props =>
      [beginningTime, endTime, bookingRange, floorsCount, city, address];
}

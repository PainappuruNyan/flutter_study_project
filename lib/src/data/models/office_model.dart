import 'package:intl/intl.dart';

import '../../domain/entities/office.dart';

class OfficeModel extends Office {
  OfficeModel({
    required super.cityId,
    required super.id,
    required super.cityName,
    required super.address,
    required super.workNumber,
    required super.startOfDay,
    required super.endOfDay,
    required super.bookingRange,
    required super.isFavorite,
  });

  var format = DateFormat('HH:mm');

  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    DateFormat format = DateFormat('hh:mm:ss');
    return OfficeModel(
      id: json['id'] as int,
      cityName: json['cityName'] as String,
      address: json['address'] as String,
      workNumber: json['workNumber'] as String,
      startOfDay: format.parse(json['startOfDay'] as String),
      endOfDay: format.parse(json['endOfDay'] as String),
      bookingRange: json['bookingRange'] as int,
      isFavorite: false, cityId: null,
    );
  }

  factory OfficeModel.fromOffice(Office simpleOffice){
    return OfficeModel(
        id: simpleOffice.id,
        cityName: simpleOffice.cityName,
        address: simpleOffice.address,
        workNumber: simpleOffice.workNumber,
        startOfDay: simpleOffice.startOfDay,
        endOfDay: simpleOffice.endOfDay,
        bookingRange: simpleOffice.bookingRange,
        isFavorite: simpleOffice.isFavorite, cityId: simpleOffice.cityId);
  }



  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'city': cityName,
      'address': address,
      'workNumber': workNumber,
      'startOfDay': format.format(startOfDay),
      'endOfDay': format.format(endOfDay),
      'bookingRange': bookingRange,
      'cityId':cityId
    };
  }
}

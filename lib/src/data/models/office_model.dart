import 'package:intl/intl.dart';

import '../../domain/entities/office.dart';

class OfficeModel extends Office{
  OfficeModel({
    required super.id,
    required super.cityName,
    required super.address,
    required super.workNumber,
    required super.startOfDay,
    required super.endOfDay,
    required super.bookingRange,
    required super.isFavorite,
  });

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
        isFavorite: false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id':id,
      'city':cityName,
      'address':address,
      'contactNumber':workNumber,
      'startOfDay':startOfDay,
      'endOfDay': endOfDay,
      'bookingRange': bookingRange
    };
  }
}

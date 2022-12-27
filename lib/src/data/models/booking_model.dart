import '../../domain/entities/booking.dart';
import 'package:timezone/standalone.dart' as tz;

class BookingModel extends Booking {
  BookingModel(
      {required super.id,
      required super.holder,
      required super.maker,
      required super.start,
      required super.end,
      required super.guests,
      required super.placeId,
      required super.officeId,
      required super.floorNumber,
      required super.address,
      required super.city,
      required super.type,
      super.holderName,
      super.makerName});

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> infoBooking =
        json['infoBooking'] as Map<String, dynamic>;
    final Map<String, dynamic> infoPlace =
        json['infoPlace'] as Map<String, dynamic>;
    final Map<String, dynamic> infoOffice =
        json['infoOffice'] as Map<String, dynamic>;
    return BookingModel(
        id: infoBooking['id'] as int,
        holder: infoBooking['holderId'] as int,
        maker: infoBooking['makerId'] as int,
        placeId: infoPlace['placeId'] as int,
        start: DateTime.parse(infoBooking['start'] as String),
        end: DateTime.parse(infoBooking['end'] as String),
        guests: infoBooking['guests'] as int,
        officeId: infoOffice['officeId'] as int,
        floorNumber: infoPlace['floorNumber'] as int,
        address: infoOffice['address'] as String,
        city: infoOffice['city'] as String,
        type: infoPlace['type'] as String,
        holderName: infoBooking['holderName'] as String,
        makerName: infoBooking['makerName'] as String);
  }

  BookingModel copyWithId({int? id}) {
    return BookingModel(
        id: id ?? this.id,
        holder: holder,
        maker: maker,
        start: start,
        end: end,
        guests: guests,
        placeId: placeId,
        officeId: officeId,
        floorNumber: floorNumber,
        address: address,
        city: city,
        type: type);
  }

  Map<String, dynamic> toJson() {
    var detroit = tz.getLocation('Asia/Vladivostok');
    var now = tz.TZDateTime.now(detroit);
    var offset = now.timeZoneOffset;
    String utcHourOffset = (offset.isNegative ? '-' : '+') +
        offset.inHours.abs().toString().padLeft(2, '0');
    String utcMinuteOffset = (offset.inMinutes - offset.inHours * 60)
        .toString().padLeft(2, '0');
    return {
      'id': id,
      'holderId': holder,
      // 'makerId': maker,
      'workPlaceId': placeId,
      'start': '${start.toIso8601String()}$utcHourOffset:$utcMinuteOffset',
      'end': '${end.toIso8601String()}$utcHourOffset:$utcMinuteOffset',
      'guests': guests,
    };
  }
}

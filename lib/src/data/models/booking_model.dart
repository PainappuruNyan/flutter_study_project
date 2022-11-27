import '../../domain/entities/booking.dart';

class BookingModel extends Booking{
  BookingModel({
    required super.id,
    required super.holder,
    required super.maker,
    required super.workplace,
    required super.start,
    required super.end,
    required super.guests
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    id: json['id'] as int,
    holder: json['holderId'] as int,
    maker: json['makerId'] as int,
    workplace: json['workplaceId'] as int,
    start: DateTime.parse(json['start'] as String),
    end: DateTime.parse(json['end'] as String),
    guests: json['guests'] as int,
  );

  Map<String, dynamic> toJson() => {
    // 'id': id,
    'holderId': holder,
    // 'makerId': maker,
    'workPlaceId': workplace,
    'start': '${start.toIso8601String()}Z',
    'end': '${end.toIso8601String()}Z',
    'guests': guests,
  };
}

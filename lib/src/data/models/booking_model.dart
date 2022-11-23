import 'package:atb_first_project/src/data/models/workplase_model.dart';

import '../../domain/entities/booking.dart';
import 'employee_model.dart';

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
    holder: EmployeeModel.fromJson(json['holder'] as Map<String, dynamic>),
    maker: EmployeeModel.fromJson(json['maker'] as Map<String, dynamic>),
    workplace: WorkplaceModel.fromJson(json['workplace'] as Map<String, dynamic>),
    start: DateTime.parse(json['start'] as String),
    end: DateTime.parse(json['end'] as String),
    guests: json['guests'] as int,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'holder': holder.toJson(),
    'maker': maker.toJson(),
    'workplace': workplace.toJson(),
    'start': start.toIso8601String(),
    'end': end.toIso8601String(),
    'guests': guests,
  };
}
import 'dart:core';

import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  const Booking({
    required this.id,
    required this.holder,
    required this.maker,
    required this.start,
    required this.end,
    required this.guests,
    required this.placeId,
    required this.type,
    required this.floorNumber,
    required this.officeId,
    required this.city,
    required this.address,
    this.holderName,
    this.makerName,
  });

  final int id;
  final int holder;
  final int maker;
  final DateTime start;
  final DateTime end;
  final int guests;
  final int placeId;
  final String? type;
  final int? floorNumber;
  final int? officeId;
  final String? city;
  final String? address;
  final String? holderName;
  final String? makerName;

  // "officeId": 0,
  // "city": "string",
  // "address": "string"
  // "placeId": 0,
  // "type": "string",
  // "floorNumber": 0
  @override
  List<Object?> get props => [id, holder, maker, placeId, start, end, guests, type, floorNumber, officeId, city, address];
}

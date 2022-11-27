import 'package:equatable/equatable.dart';

class Booking extends Equatable{
  const Booking({
    required this.id,
    required this.holder,
    required this.maker,
    required this.workplace,
    required this.start,
    required this.end,
    required this.guests,
  });

  final int id;
  final int holder;
  final int maker;
  final int workplace;
  final DateTime start;
  final DateTime end;
  final int guests;

  @override
  List<Object> get props => [id, holder, maker, workplace, start, end, guests];
}
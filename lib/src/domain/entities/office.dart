import 'package:equatable/equatable.dart';

class Office extends Equatable{
  const Office({
    required this.id,
    required this.city,
    required this.address,
    required this.administrator,
    required this.contactNumber
});

  final int id;
  final String city;
  final String address;
  final String administrator;
  final String contactNumber;

  @override
  List<Object> get props => [id, city, address, administrator, contactNumber];
}

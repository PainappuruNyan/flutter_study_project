import '../../domain/entities/office.dart';

class OfficeModel extends Office{
  const OfficeModel({
    required super.id,
    required super.city,
    required super.address,
    required super.administrator,
    required super.contactNumber});

  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    return OfficeModel(
        id: json['id'] as int,
        city: json['city'] as String,
        address: json['address'] as String,
        administrator:json['administrator'] as String,
        contactNumber: json['contactNumber'] as String);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id':id,
      'city':city,
      'address':address,
      'administrator':administrator,
      'contactNumber':contactNumber
    };
  }
}

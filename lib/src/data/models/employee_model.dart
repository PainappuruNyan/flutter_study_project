import '../../domain/entities/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required super.id,
    required super.role,
    required super.fullName,
    required super.login,
    required super.email,
    required super.phoneNumber,
    required super.imageId,
  });

  String get roleString{
    if(role == 'ROLE_ADMIN'){
      return 'Админ';
    }
    return 'Сотрудник';
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    id: json['id'] as int,
    role: json['role'] as String,
    fullName: json['fullName'] as String,
    login: json['login'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    imageId: json['imageId'] as int?,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'role': role,
    'fullName': fullName,
    'login': login,
    'email': email,
    'phoneNumber': phoneNumber,
    'imageId': imageId,
  };
}

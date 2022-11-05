import '../../domain/entities/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({required super.id, required super.name,
    required super.login, required super.password,
    required super.role});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(id: json['id'] as int,
        name: json['name'] as String,
        login: json['login'] as String,
        password: json['password'] as String,
        role: json['role'] as String);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'login': login,
      'password': password,
      'role': role
    };
  }

}

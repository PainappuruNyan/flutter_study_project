import 'package:equatable/equatable.dart';
class Employee extends Equatable{
  const Employee({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    required this.role
  });

  final int id;
  final String name;
  final String login;
  final String password;
  final String role;

  @override
  List<Object> get props => [id, name, login, password, role];
}

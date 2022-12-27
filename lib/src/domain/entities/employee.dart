import 'package:equatable/equatable.dart';
class Employee extends Equatable{
  const Employee({
    required this.id,
    required this.role,
    required this.fullName,
    required this.login,
    required this.email,
    required this.phoneNumber,
    required this.imageId,
  });

  final int id;
  final String role;
  final String fullName;
  final String login;
  final String email;
  final String phoneNumber;
  final int? imageId;

  @override
  List<Object> get props => [id, role, fullName,  login, email, phoneNumber];
}

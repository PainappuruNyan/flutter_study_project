import 'package:equatable/equatable.dart';

import '../../data/models/booking_model.dart';
import '../../data/models/employee_model.dart';
import '../../data/models/team_model.dart';


class Profile extends Equatable{
  const Profile({
    required this.employee,
    required this.bookings,
    required this.teams,
  });

  final EmployeeModel employee;
  final BookingModel? bookings;
  final TeamModel? teams;

  @override
  List<Object?> get props => [employee, bookings, teams];
}

import 'package:atb_first_project/src/data/models/team_model.dart';

import '../../domain/entities/profile.dart';
import 'booking_model.dart';
import 'employee_model.dart';

class ProfileModel extends Profile{
  ProfileModel({
    required super.employee,
    required super.bookings,
    required super.teams});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {

    List<TeamModel>? tempteam;
    if(json['teams'] == null){
      tempteam = null;
    } else {
      tempteam = List<TeamModel>.from(json['teams']?.map((x) => TeamModel.fromJson(x as Map<String, dynamic>)).toList() as List<dynamic>);
    }
    return ProfileModel(
      employee: EmployeeModel.fromJson(json['employee'] as Map<String, dynamic>),
      bookings: json['firstBooking']!=null ? BookingModel.fromJson(json['firstBooking']  as Map<String, dynamic>): null,
      teams: json['firstTeam'] != null ?  TeamModel.fromJson(json['firstTeam'] as Map<String, dynamic>):null ,
    );
  }

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //   'employee': employee.toJson(),
  //   'bookings': dynamic>.from(bookings!.map((x) => x.toJson())),
  //   'teams': List<dynamic>.from(teams!.map((x) => x.toJson())),
  // };

}
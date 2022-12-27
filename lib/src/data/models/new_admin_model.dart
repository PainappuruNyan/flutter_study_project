import '../../domain/entities/new_admin.dart';

class NewAdminModel extends NewAdmin{
  const NewAdminModel({
    required super.employeeId,
    required super.officeId,
  });

  factory NewAdminModel.fromJson(Map<String, dynamic> json){
    return NewAdminModel(
      employeeId: json['employeeId'] as int,
      officeId: json['officeId'] as int,
    );
  }

  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      'employeeId': employeeId,
      'officeId': officeId
    };
  }
}
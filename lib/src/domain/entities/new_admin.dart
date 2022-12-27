import 'package:equatable/equatable.dart';

class NewAdmin extends Equatable{
  const NewAdmin({
    required this.employeeId,
    required this.officeId
  });

  final int employeeId;
  final int officeId;

  @override
  List<Object> get props => [employeeId, officeId];
}
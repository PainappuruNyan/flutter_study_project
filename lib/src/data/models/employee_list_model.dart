import '../../domain/entities/employee_list.dart';
import 'employee_model.dart';

class EmployeeListModel extends EmployeeList{
  const EmployeeListModel({required super.employees});

  factory EmployeeListModel.fromJson(List<dynamic> json) {
    final List<EmployeeModel> employees = json.map((i)=>EmployeeModel.fromJson(i as Map<String, dynamic>)).toList();
    return EmployeeListModel(employees: employees);
  }
}
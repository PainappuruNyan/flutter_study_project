import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exeptions/exceptions.dart';
import '../models/employee_model.dart';

abstract class LocalDataSource{
  Future<EmployeeModel> getCachedEmployee();
  Future<Unit> cacheEmployee(EmployeeModel employeeModel);
}

const String CASHED_EMPLOYEE = 'CACHED_EMPLOYEE';


class LocalDataSourceImpl implements LocalDataSource{
  LocalDataSourceImpl({
    required this.sharedPreferences
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<Unit> cacheEmployee(EmployeeModel employeeModel) {
    Map<String, dynamic> employeeModelToJson = employeeModel.toJson();
    sharedPreferences.setString(CASHED_EMPLOYEE, json.encode(employeeModelToJson));
    return Future.value(unit);
  }

  @override
  Future<EmployeeModel> getCachedEmployee() {
    final String? jsonString = sharedPreferences.getString('CACHED_EMPLOYEE');
    if(jsonString != null){
      Map<String, dynamic> decodeJsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      EmployeeModel jsonToEmployeeModel = EmployeeModel.fromJson(decodeJsonData);
      return Future.value(jsonToEmployeeModel);
    } else {
      throw EmptyCacheException();
    }
  }
  
}
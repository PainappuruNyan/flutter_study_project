import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exeptions/exceptions.dart';
import '../models/employee_model.dart';
import '../models/profile_model.dart';

abstract class LocalDataSource{
  Future<EmployeeModel> getCachedEmployee();
  Future<Unit> cacheEmployee(EmployeeModel employeeModel);
  Future<Unit> cacheProfile(ProfileModel profileModel);
  Future<ProfileModel> getCachedProfile();
}

const String CASHED_EMPLOYEE = 'CACHED_EMPLOYEE';
const String CASHED_PROFILE = 'CASHED_PROFILE';


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

  @override
  Future<Unit> cacheProfile(ProfileModel profileModel) {
    Map<String, dynamic> profileModelToJson = profileModel.toJson();
    sharedPreferences.setString(CASHED_PROFILE, json.encode(profileModelToJson));
    return Future.value(unit);
  }

  @override
  Future<ProfileModel> getCachedProfile() {
    final String? jsonString = sharedPreferences.getString('CASHED_PROFILE');
    if(jsonString != null){
      Map<String, dynamic> decodeJsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      ProfileModel jsonToProfileModel = ProfileModel.fromJson(decodeJsonData);
      return Future.value(jsonToProfileModel);
    } else {
      throw EmptyCacheException();
    }
  }
  
}
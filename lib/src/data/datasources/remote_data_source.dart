import 'dart:convert';
import 'dart:io';

import '../../core/exeptions/exceptions.dart';
import '../models/employee_model.dart';
import 'package:http/http.dart' as http;

import '../models/profile_model.dart';

abstract class RemoteDataSource {
  Future<EmployeeModel> getEmployeeById(int id);

  Future<EmployeeModel> getEmployeeByLogin(String login);

  Future<ProfileModel> getProfile();
}

const String BASE_URL = 'http://10.0.2.2:8080';

class RemoteImplWithHttp implements RemoteDataSource {
  RemoteImplWithHttp({required this.client});

  final http.Client client;

  @override
  Future<EmployeeModel> getEmployeeById(int id) async {
    final http.Response response = await client.get(
      Uri.parse('$BASE_URL/employee/id${id.toString()}'),
    );
    //then catch
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final EmployeeModel jsonToEmployeeModel =
          EmployeeModel.fromJson(decodeJsonData);
      return Future.value(jsonToEmployeeModel);
    } else {
      print(response.toString());
      throw ServerException();
    }
  }

  @override
  Future<EmployeeModel> getEmployeeByLogin(String login) async {
    final http.Response response = await client.get(
      Uri.parse('$BASE_URL/employee/$login'),
      headers: {
        HttpHeaders.authorizationHeader: 'Basic cTpxdw=='
      }
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(response.body) as Map<String, dynamic>;
      final EmployeeModel jsonToEmployeeModel =
          EmployeeModel.fromJson(decodeJsonData);
      return Future.value(jsonToEmployeeModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/profile'),
        headers: {HttpHeaders.authorizationHeader: 'Basic cTpxdw=='});
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(response.body) as Map<String, dynamic>;
      final ProfileModel jsonToProfileModel = ProfileModel.fromJson(decodeJsonData);
      return Future.value(jsonToProfileModel);
    } else {
      throw ServerException();
    }
  }

}

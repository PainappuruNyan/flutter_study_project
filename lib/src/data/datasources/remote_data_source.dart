import 'dart:convert';

import '../../core/exeptions/exceptions.dart';
import '../models/employee_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<EmployeeModel> getEmployeeById(int id);
  Future<EmployeeModel> getEmployeeByLogin(String login);
}


//http://localhost:8080/employee/id1
const BASE_URL = 'http://10.0.2.2:8080';

class RemoteImplWithHttp implements RemoteDataSource {
  RemoteImplWithHttp({
    required this.client
  });

  final http.Client client;

  @override
  Future<EmployeeModel> getEmployeeById(int id) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/employee/id${id.toString()}'),
    );
    if(response.statusCode == 200){
      Map<String, dynamic> decodeJsonData = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      EmployeeModel jsonToEmployeeModel = EmployeeModel.fromJson(decodeJsonData);
      return Future.value(jsonToEmployeeModel);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<EmployeeModel> getEmployeeByLogin(String login) async{
    final http.Response response = await client.get(
      Uri.parse('$BASE_URL/employee/id$login'),
    );
    if(response.statusCode == 200){
      Map<String, dynamic> decodeJsonData = jsonDecode(response.body) as Map<String, dynamic>;
      EmployeeModel jsonToEmployeeModel = EmployeeModel.fromJson(decodeJsonData);
      return Future.value(jsonToEmployeeModel);
    }else{
      throw ServerException();
    }
  }

}

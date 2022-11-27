import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exeptions/exceptions.dart';
import '../models/booking_list_model.dart';
import '../models/employee_model.dart';
import 'package:http/http.dart' as http;

import 'package:atb_first_project/dependency_injection_container.dart' as di;

import '../models/office_list_model.dart';
import '../models/office_model.dart';
import '../models/profile_model.dart';

abstract class RemoteDataSource {
  Future<EmployeeModel> getEmployeeById(int id);
  Future<EmployeeModel> getEmployeeByLogin(String login);

  Future<ProfileModel> getProfile();
  Future<ProfileModel> getProfileByCredits(String username, String password);

  Future<OfficeListModel> getOffices();
  Future<OfficeModel> getOfficeById(int id);

  Future<BookingListModel> getAllActual();
  Future<BookingListModel> getAllSelf();
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
      return Future<EmployeeModel>.value(jsonToEmployeeModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<EmployeeModel> getEmployeeByLogin(String login) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
      Uri.parse('$BASE_URL/employee/$login'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}'
      }
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(response.body) as Map<String, dynamic>;
      final EmployeeModel jsonToEmployeeModel =
          EmployeeModel.fromJson(decodeJsonData);
      return Future<EmployeeModel>.value(jsonToEmployeeModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/profile'),
        headers: <String, String>{HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}'});
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final ProfileModel jsonToProfileModel = ProfileModel.fromJson(decodeJsonData);
      return Future.value(jsonToProfileModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> getProfileByCredits(String username, String password) async {
    final SharedPreferences sharedPreference = di.sl();
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/profile'),
        headers: <String, String>{HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}'});
    if (response.statusCode == 200) {
      sharedPreference.setString('username', username);
      sharedPreference.setString('password', password);
      final Map<String, dynamic> decodeJsonData =
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final ProfileModel jsonToProfileModel = ProfileModel.fromJson(decodeJsonData);
      return Future<ProfileModel>.value(jsonToProfileModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OfficeModel> getOfficeById(int id) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/office/id$id'),
        headers: <String, String>{HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}'});
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final OfficeModel jsonToOfficeModel = OfficeModel.fromJson(decodeJsonData);
      return Future<OfficeModel>.value(jsonToOfficeModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OfficeListModel> getOffices() async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/office/all'),
        headers: <String, String>{HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}'});
    if (response.statusCode == 200) {
      final List<dynamic> decodeJsonData =
      jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      final OfficeListModel jsonToOfficeListModel = OfficeListModel.fromJson(decodeJsonData);
      return Future<OfficeListModel>.value(jsonToOfficeListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<BookingListModel> getAllActual() async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/booking/allActual?id=0'),
        headers: <String, String>{HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}'});
    if (response.statusCode == 200) {
      final List<dynamic> decodeJsonData =
      jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      final BookingListModel jsonToBookingListModel = BookingListModel.fromJson(decodeJsonData);
      return Future<BookingListModel>.value(jsonToBookingListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<BookingListModel> getAllSelf() async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/booking/allSelf?pageNumber=0'),
        headers: <String, String>{HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}'});
    if (response.statusCode == 200) {
      final List<dynamic> decodeJsonData =
      jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      final BookingListModel jsonToBookingListModel = BookingListModel.fromJson(decodeJsonData);
      return Future<BookingListModel>.value(jsonToBookingListModel);
    } else {
      throw ServerException();
    }
  }


}

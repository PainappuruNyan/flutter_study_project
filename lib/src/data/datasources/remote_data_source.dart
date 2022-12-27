import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dependency_injection_container.dart' as di;
import '../../bloc/office_create_2/office_create_2_bloc.dart';
import '../../core/exeptions/exceptions.dart';
import '../../core/utils/date_time_parser.dart';
import '../models/booking_list_model.dart';
import '../models/booking_model.dart';
import '../models/city_list_model.dart';
import '../models/employee_list_model.dart';
import '../models/employee_model.dart';
import '../models/floor_list_model.dart';
import '../models/floor_model.dart';
import '../models/new_admin_model.dart';
import '../models/office_list_model.dart';
import '../models/office_model.dart';
import '../models/profile_model.dart';
import '../models/team_list_model.dart';
import '../models/team_model.dart';
import '../models/teammate_list_model.dart';
import '../models/teammate_model.dart';
import '../models/time_interval_list_model.dart';
import '../models/user_feedback_model.dart';
import '../models/workplace_list_model.dart';
import '../models/workplase_model.dart';
import 'package:http_parser/http_parser.dart';

abstract class RemoteDataSource {
  Future<EmployeeModel> getEmployeeById(int id);

  Future<EmployeeModel> getEmployeeByLogin(String login);

  Future<EmployeeListModel> getEmployeeByName(String name, int page);

  Future<ProfileModel> getProfile();

  Future<ProfileModel> getProfileByCredits(String username, String password);

  Future<OfficeListModel> getOffices();

  Future<OfficeModel> getOfficeById(int id);

  Future<OfficeListModel> getAdminOffices(int adminId);

  Future<String> postOffice(OfficeModel office);

  Future<String> editOffice(OfficeModel office);

  Future<BookingListModel> getAllActual();

  Future<BookingListModel> getAllSelf();

  Future<BookingListModel> getOfficeBooking(int officeId, int type, bool isActual, int page);

  Future<String> deleteBooking({required int id});
  Future<String> editBooking({required BookingModel booking});

  Future<String> postNewBooking({required BookingModel booking});

  Future<CityListModel> getCitesAll();

  Future<TeamListModel> getMyTeam({required int id});

  Future<TeamListModel> getAllTeam();

  Future<String> postNewTeam({required TeamModel team});

  Future<String> deleteTeam({required int id});

  Future<String> editTeam({required TeamModel team});

  Future<TeammateListModel> getTeammate({required int teamId});

  Future<String> deleteTeammate({required int employeeId, required int teamId});

  Future<String> addTeammate({required TeammateModel teammate});

  Future<FloorListModel> getFloors(int officeId);

  Future<FloorModel> getFloor(int floorId);

  Future<WorkplaceListModel> getWorkplaces(
      int floorId, int type, DateTime start, DateTime end);

  Future<String> postFloors(List<MiniFloor> floors);

  Future<WorkplaceListModel> getWorkplacesByFloor(int floorId, int typeId);

  Future<String> postAdmin(NewAdminModel admin);

  Future<String> postWorkplace(WorkplaceModel place);

  Future<String> updateWorkplace(WorkplaceModel place);

  Future<String> deleteWorkplace(int placeId);

  Future<TimeIntervalListModel> getFreeIntervals(int placeId, DateTime date);

  Future<WorkplaceListModel> getRemoteFavorites(
      int floorId, DateTime start, DateTime end);

  Future<String> postFavorite(int id);

  Future<String> deleteFavorite(int id);

  Future<String> deleteOffice({required int id});

  Future<String> postFloorImage(String imagePath, int floorId);
  Future<String> postFeedback({required UserFeedbackModel feedback});

}

const String BASE_URL = 'http://10.0.2.2:8080';

class RemoteImplWithHttp implements RemoteDataSource {
  RemoteImplWithHttp({required this.client});

  final http.Client client;

  @override
  Future<EmployeeModel> getEmployeeById(int id) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client
        .get(Uri.parse('$BASE_URL/employee/$id'), headers: <String, String>{
      HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
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
    final http.Response response = await client
        .get(Uri.parse('$BASE_URL/employee/$login'), headers: <String, String>{
      HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
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
  Future<EmployeeListModel> getEmployeeByName(String query, int page) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/employee/allByName').replace(
          queryParameters: {
            'name': query,
            'page': page,
          }.map((String key, Object value) => MapEntry(key, value.toString())),
        ),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final EmployeeListModel jsonToEmployeeListModel =
          EmployeeListModel.fromJson(
              decodeJsonData['content'] as List<dynamic>);
      return Future<EmployeeListModel>.value(jsonToEmployeeListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client
        .get(Uri.parse('$BASE_URL/profile'), headers: <String, String>{
      HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final ProfileModel jsonToProfileModel =
          ProfileModel.fromJson(decodeJsonData);
      return Future.value(jsonToProfileModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> getProfileByCredits(
      String username, String password) async {
    final SharedPreferences sharedPreference = di.sl();
    final http.Response response = await client
        .get(Uri.parse('$BASE_URL/profile'), headers: <String, String>{
      HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    if (response.statusCode == 200) {
      sharedPreference.setString('username', username);
      sharedPreference.setString('password', password);
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final ProfileModel jsonToProfileModel =
          ProfileModel.fromJson(decodeJsonData);
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
    final http.Response response = await client
        .get(Uri.parse('$BASE_URL/office/id$id'), headers: <String, String>{
      HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final OfficeModel jsonToOfficeModel =
          OfficeModel.fromJson(decodeJsonData);
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
    final http.Response response = await client
        .get(Uri.parse('$BASE_URL/office/all'), headers: <String, String>{
      HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final OfficeListModel jsonToOfficeListModel =
          OfficeListModel.fromJson(decodeJsonData['content'] as List<dynamic>);
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
        Uri.parse('$BASE_URL/booking/allActualSelf'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final BookingListModel jsonToBookingListModel =
          BookingListModel.fromJson(decodeJsonData['content'] as List<dynamic>);
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
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final BookingListModel jsonToBookingListModel =
          BookingListModel.fromJson(decodeJsonData['content'] as List<dynamic>);
      return Future<BookingListModel>.value(jsonToBookingListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> postNewBooking({required BookingModel booking}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(booking.toJson());
    final http.Response response =
        await client.post(Uri.parse('$BASE_URL/booking/'),
            headers: <String, String>{
              HttpHeaders.authorizationHeader:
                  'Basic ${base64.encode(utf8.encode('$username:$password'))}',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteBooking({required int id}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.delete(
      Uri.parse('$BASE_URL/booking/$id'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader:
            'Basic ${base64.encode(utf8.encode('$username:$password'))}',
        HttpHeaders.contentTypeHeader: 'application/json'
      },
    );
    if (response.statusCode == 200) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> editBooking({required BookingModel booking}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(booking.toJson());
    final http.Response response =
    await client.put(Uri.parse('$BASE_URL/booking/'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: body);
    if (response.statusCode == 200) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }


  @override
  Future<CityListModel> getCitesAll() async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client
        .get(Uri.parse('$BASE_URL/city/all'), headers: <String, String>{
      HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    if (response.statusCode == 200) {
      final List<dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      final CityListModel jsonToCityListModel =
          CityListModel.fromJson(decodeJsonData);
      return Future<CityListModel>.value(jsonToCityListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TeamListModel> getMyTeam({required int id}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/team_member/all/employee/$id?page=0&size=20'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final TeamListModel jsonToTeamListModel =
          TeamListModel.fromJson(decodeJsonData['content'] as List<dynamic>);
      return Future<TeamListModel>.value(jsonToTeamListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TeamListModel> getAllTeam() async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/team/all?page=0&size=20'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final TeamListModel jsonToTeamListModel =
          TeamListModel.fromJson(decodeJsonData['content'] as List<dynamic>);
      return Future<TeamListModel>.value(jsonToTeamListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> postNewTeam({required TeamModel team}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(team.toJson());
    final http.Response response =
        await client.post(Uri.parse('$BASE_URL/team/'),
            headers: <String, String>{
              HttpHeaders.authorizationHeader:
                  'Basic ${base64.encode(utf8.encode('$username:$password'))}',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteTeam({required int id}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.delete(
      Uri.parse('$BASE_URL/team/$id'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader:
            'Basic ${base64.encode(utf8.encode('$username:$password'))}',
        HttpHeaders.contentTypeHeader: 'application/json'
      },
    );
    if (response.statusCode == 200) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> editTeam({required TeamModel team}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(team.toJson());
    final http.Response response =
        await client.put(Uri.parse('$BASE_URL/team/'),
            headers: <String, String>{
              HttpHeaders.authorizationHeader:
                  'Basic ${base64.encode(utf8.encode('$username:$password'))}',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: body);
    if (response.statusCode == 200) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TeammateListModel> getTeammate({required int teamId}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/team_member/all/team/$teamId?&page=0&size=20'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final TeammateListModel jsonToTeammateListModel =
          TeammateListModel.fromJson(
              decodeJsonData['content'] as List<dynamic>);
      return Future<TeammateListModel>.value(jsonToTeammateListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteTeammate(
      {required int employeeId, required int teamId}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.delete(
      Uri.parse('$BASE_URL/team_member/employee/$employeeId/team/$teamId'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader:
            'Basic ${base64.encode(utf8.encode('$username:$password'))}',
        HttpHeaders.contentTypeHeader: 'application/json'
      },
    );
    if (response.statusCode == 200) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> addTeammate({required TeammateModel teammate}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(teammate.toJson());
    final http.Response response =
        await client.post(Uri.parse('$BASE_URL/team_member/'),
            headers: <String, String>{
              HttpHeaders.authorizationHeader:
                  'Basic ${base64.encode(utf8.encode('$username:$password'))}',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<FloorListModel> getFloors(int officeId) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/floor/all?officeId=$officeId&page=0&size=20'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final FloorListModel jsonToFloorListModel =
          FloorListModel.fromJson(decodeJsonData['content'] as List<dynamic>);
      return Future<FloorListModel>.value(jsonToFloorListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WorkplaceListModel> getWorkplaces(
      int floorId, int type, DateTime start, DateTime end) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse(
            '$BASE_URL/workplace/allIsFreeByFloor?floorId=$floorId&typeId=$type&start=${DateParser.parseForGetRequest(start)}&end=${DateParser.parseForGetRequest(end)}&page=0&size=20'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final WorkplaceListModel jsonToFloorListModel =
          WorkplaceListModel.fromJson(
              decodeJsonData['content'] as List<dynamic>);
      return Future<WorkplaceListModel>.value(jsonToFloorListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TimeIntervalListModel> getFreeIntervals(
      int placeId, DateTime date) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final DateFormat format = DateFormat('yyyy-MM-dd');
    final http.Response response = await client.get(
        Uri.parse(
            '$BASE_URL/workplace/freeIntervals?placeId=$placeId&date=${format.format(date)}'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final List<dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      final TimeIntervalListModel jsonToTimeIntervalListModel =
          TimeIntervalListModel.fromJson(decodeJsonData);
      return Future<TimeIntervalListModel>.value(jsonToTimeIntervalListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WorkplaceListModel> getRemoteFavorites(
      int floorId, DateTime start, DateTime end) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse(
            '$BASE_URL/favPlace/allSelfIsFree?floorId=$floorId&start=${DateParser.parseForGetRequest(start)}&end=${DateParser.parseForGetRequest(end)}'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final List<dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      final WorkplaceListModel favoritesPlaceListModel =
          WorkplaceListModel.fromJson(decodeJsonData);
      return Future<WorkplaceListModel>.value(favoritesPlaceListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteFavorite(int id) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.delete(
        Uri.parse('$BASE_URL/favPlace/self/$id'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      final String answer = decodeJsonData;
      return Future<String>.value(answer);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> postFavorite(int id) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response =
        await client.post(Uri.parse('$BASE_URL/favPlace/?placeId=$id'),
            headers: <String, String>{
              HttpHeaders.authorizationHeader:
                  'Basic ${base64.encode(utf8.encode('$username:$password'))}',
              HttpHeaders.contentTypeHeader: 'application/json'
            },);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      final String answer = decodeJsonData;
      return Future<String>.value(answer);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> postOffice(OfficeModel office) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(office.toJson());
    final http.Response response =
        await client.post(Uri.parse('$BASE_URL/office/'),
            headers: <String, String>{
              HttpHeaders.authorizationHeader:
                  'Basic ${base64.encode(utf8.encode('$username:$password'))}',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> editOffice(OfficeModel office) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(office.toJson());
    final http.Response response =
        await client.put(Uri.parse('$BASE_URL/office/'),
            headers: <String, String>{
              HttpHeaders.authorizationHeader:
                  'Basic ${base64.encode(utf8.encode('$username:$password'))}',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: body);
    if (response.statusCode == 200) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> postFloors(List<MiniFloor> floors) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    for (final MiniFloor f in floors) {
      final String body = json.encode(FloorModel.fromMini(f).toJson());
      final http.Response response =
          await client.post(Uri.parse('$BASE_URL/floor/'),
              headers: <String, String>{
                HttpHeaders.authorizationHeader:
                    'Basic ${base64.encode(utf8.encode('$username:$password'))}',
                HttpHeaders.contentTypeHeader: 'application/json'
              },
              body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        f.setWorkplaces();
        final String decodeJsonData = utf8.decode(response.bodyBytes);
        final int nFloorId = int.parse(decodeJsonData);
        for (MiniWorkplace p in f.meetingRooms) {
          final String body =
              json.encode(WorkplaceModel.fromMini(p, nFloorId).toJson());
          final http.Response response =
              await client.post(Uri.parse('$BASE_URL/workplace/'),
                  headers: <String, String>{
                    HttpHeaders.authorizationHeader:
                        'Basic ${base64.encode(utf8.encode('$username:$password'))}',
                    HttpHeaders.contentTypeHeader: 'application/json'
                  },
                  body: body);
          if (response.statusCode == 200 || response.statusCode == 201) {
          } else {
            throw ServerException();
          }
        }
        for (MiniWorkplace p in f.workplaces) {
          final String body =
              json.encode(WorkplaceModel.fromMini(p, nFloorId).toJson());
          final http.Response response =
              await client.post(Uri.parse('$BASE_URL/workplace/'),
                  headers: <String, String>{
                    HttpHeaders.authorizationHeader:
                        'Basic ${base64.encode(utf8.encode('$username:$password'))}',
                    HttpHeaders.contentTypeHeader: 'application/json'
                  },
                  body: body);
          if (response.statusCode == 200 || response.statusCode == 201) {
          } else {
            throw ServerException();
          }
        }
      } else {
        throw ServerException();
      }
    }
    return Future<String>.value('Вроде успех');
  }

  @override
  Future<WorkplaceListModel> getWorkplacesByFloor(
      int floorId, int typeId) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse(
            '$BASE_URL/workplace/allByFloor?floorId=$floorId&typeId=$typeId&page=0&size=20'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final WorkplaceListModel jsonToFloorListModel =
          WorkplaceListModel.fromJson(
              decodeJsonData['content'] as List<dynamic>);
      return Future<WorkplaceListModel>.value(jsonToFloorListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> postFeedback({required UserFeedbackModel feedback}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(feedback.toJson()) ;
    final http.Response response = await client.post(
        Uri.parse('$BASE_URL/feedback/'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: body
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final String decodeJsonData =
      utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OfficeListModel> getAdminOffices(int adminId) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse(
            '$BASE_URL/administrating/officesOfAdmin/$adminId?page=0&size=20'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final OfficeListModel jsonToFloorListModel =
          OfficeListModel.fromJson(decodeJsonData['content'] as List<dynamic>);
      return Future<OfficeListModel>.value(jsonToFloorListModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteOffice({required int id}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.delete(
      Uri.parse('$BASE_URL/office/$id'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader:
            'Basic ${base64.encode(utf8.encode('$username:$password'))}',
        HttpHeaders.contentTypeHeader: 'application/json'
      },
    );
    if (response.statusCode == 200) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> postAdmin(NewAdminModel admin) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(admin.toJson());
    final http.Response response =
        await client.post(Uri.parse('$BASE_URL/administrating/'),
            headers: <String, String>{
              HttpHeaders.authorizationHeader:
                  'Basic ${base64.encode(utf8.encode('$username:$password'))}',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> postFloorImage(String imagePath, int floorId) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse('$BASE_URL/image/floor/$floorId'));

    request.headers.addAll(<String, String>{
      HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}',
      HttpHeaders.contentTypeHeader: 'multipart/form-data'
    });
    request.headers["Content-type"] = ' multipart/form-data';
    request.headers["Accept"] = "application/json";
    final http.MultipartFile pic =
        await http.MultipartFile.fromPath('file', imagePath, contentType: MediaType('image', 'jpeg'));
    request.files.add(pic);
    final http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      response.stream.transform(utf8.decoder).listen((String value) {});
      return Future.value('Загрузили');
    } else {
      response.stream.transform(utf8.decoder).listen((String value) {
      });
      throw ServerException();
    }
    // listen for response
  }

  @override
  Future<FloorModel> getFloor(int floorId) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client
        .get(Uri.parse('$BASE_URL/floor/$floorId'), headers: <String, String>{
      HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final FloorModel jsonToFloorModel = FloorModel.fromJson(decodeJsonData);
      return Future<FloorModel>.value(jsonToFloorModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteWorkplace(int placeId) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.delete(
        Uri.parse('$BASE_URL/workplace/$placeId'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
        });
    if (response.statusCode == 200) {
      return Future<String>.value(utf8.decode(response.bodyBytes));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> postWorkplace(WorkplaceModel place) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(place.toJson());
    final http.Response response =
        await client.post(Uri.parse('$BASE_URL/workplace/'),
            headers: <String, String>{
              HttpHeaders.authorizationHeader:
                  'Basic ${base64.encode(utf8.encode('$username:$password'))}',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Future<String>.value(utf8.decode(response.bodyBytes));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> updateWorkplace(WorkplaceModel place) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(place.toJson());
    final http.Response response =
        await client.put(Uri.parse('$BASE_URL/workplace/'),
            headers: <String, String>{
              HttpHeaders.authorizationHeader:
                  'Basic ${base64.encode(utf8.encode('$username:$password'))}',
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: body);
    if (response.statusCode == 200) {
      return Future<String>.value(utf8.decode(response.bodyBytes));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<BookingListModel> getOfficeBooking(int officeId, int type, bool isActual, int page) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/booking/office/').replace(
          queryParameters: {
            'officeId': officeId,
            'typeId': type,
            'isActual': isActual,
            'page': page,
          }.map((String key, Object value) => MapEntry(key, value.toString())),
        ),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final BookingListModel jsonToBookingListModel =
      BookingListModel.fromJson(decodeJsonData['content'] as List<dynamic>);
      return Future<BookingListModel>.value(jsonToBookingListModel);
    } else {
      throw ServerException();
    }
  }
}

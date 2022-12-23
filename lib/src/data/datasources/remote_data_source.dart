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
import '../models/office_list_model.dart';
import '../models/office_model.dart';
import '../models/profile_model.dart';
import '../models/team_list_model.dart';
import '../models/team_model.dart';
import '../models/teammate_list_model.dart';
import '../models/teammate_model.dart';
import '../models/time_interval_list_model.dart';
import '../models/workplace_list_model.dart';
import '../models/workplase_model.dart';

abstract class RemoteDataSource {
  Future<EmployeeModel> getEmployeeById(int id);
  Future<EmployeeModel> getEmployeeByLogin(String login);
  Future<EmployeeListModel> getEmployeeByName(String name, int page);

  Future<ProfileModel> getProfile();
  Future<ProfileModel> getProfileByCredits(String username, String password);

  Future<OfficeListModel> getOffices();
  Future<OfficeModel> getOfficeById(int id);
  Future<String> postOffice(OfficeModel office);

  Future<BookingListModel> getAllActual();
  Future<BookingListModel> getAllSelf();
  Future<String> deleteBooking({required int id});

  Future<String> postNewBooking({required BookingModel booking});

  Future<CityListModel> getCitesAll();

  Future<TeamListModel> getMyTeam();
  Future<TeamListModel> getAllTeam();

  Future<String> postNewTeam({required TeamModel team});
  Future<String> deleteTeam({required int id});
  Future<String> editTeam({required TeamModel team});

  Future<TeammateListModel> getTeammate({required int teamId});
  Future<String> deleteTeammate({required int employeeId, required int teamId});
  Future<String> addTeammate({required TeammateModel teammate});

  Future<FloorListModel> getFloors(int officeId);
  Future<WorkplaceListModel> getWorkplaces(int floorId, int type, DateTime start, DateTime end);
  Future<String> postFloors(List<MiniFloor> floors);
  Future<WorkplaceListModel> getWorkplacesByFloor(int floorId, int typeId);

  Future<TimeIntervalListModel> getFreeIntervals(int placeId, DateTime date);

  Future<WorkplaceListModel> getRemoteFavorites(
      int floorId, DateTime start, DateTime end);

  Future<String> postFavorite(int id);

  Future<String> deleteFavorite(int id);
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
    final http.Response response = await client
        .get(Uri.parse('$BASE_URL/employee/$login'), headers: <String, String>{
      HttpHeaders.authorizationHeader:
          'Basic ${base64.encode(utf8.encode('$username:$password'))}'
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
              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
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
          'Basic ${base64.encode(utf8.encode('$username:$password'))}'
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final ProfileModel jsonToProfileModel =
          ProfileModel.fromJson(decodeJsonData);
      return Future.value(jsonToProfileModel);
    } else {
      print(utf8.decode(response.bodyBytes));
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
          'Basic ${base64.encode(utf8.encode('$username:$password'))}'
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
      print(utf8.decode(response.bodyBytes));
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
          'Basic ${base64.encode(utf8.encode('$username:$password'))}'
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
          'Basic ${base64.encode(utf8.encode('$username:$password'))}'
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
              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
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
              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
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
    print('Тело при отправке: $body');
    final http.Response response =
        await client.post(Uri.parse('$BASE_URL/booking/'),
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
      print(response.body);
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
      print(response.body);
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
          'Basic ${base64.encode(utf8.encode('$username:$password'))}'
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
  Future<TeamListModel> getMyTeam() async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/team/all?page=0&size=20'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
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
              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
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
    print(body);
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
      print(response.body);
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
      print(response.body);
      throw ServerException();
    }
  }

  @override
  Future<String> editTeam({required TeamModel team}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(team.toJson());
    print(body);
    final http.Response response =
        await client.post(Uri.parse('$BASE_URL/team/'),
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
      print(response.body);
      throw ServerException();
    }
  }

  @override
  Future<TeammateListModel> getTeammate({required int teamId}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse(
            '$BASE_URL/team_member/all/team/$teamId?&page=0&size=20'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
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
      Uri.parse('$BASE_URL/team_member/$employeeId/$teamId'),
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
      print(response.body);
      throw ServerException();
    }
  }

  @override
  Future<String> addTeammate({required TeammateModel teammate}) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(teammate.toJson());
    print(body);
    final http.Response response =
        await client.post(Uri.parse('$BASE_URL/team_member/'),
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
      print(response.body);
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
              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
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
    print(floorId);
    final http.Response response = await client.get(
        Uri.parse(
            '$BASE_URL/workplace/allIsFreeByFloor?floorId=$floorId&typeId=$type&start=${DateParser.parseForGetRequest(start)}&end=${DateParser.parseForGetRequest(end)}&page=0&size=20'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final WorkplaceListModel jsonToFloorListModel =
          WorkplaceListModel.fromJson(
              decodeJsonData['content'] as List<dynamic>);
      print(jsonToFloorListModel);
      return Future<WorkplaceListModel>.value(jsonToFloorListModel);
    } else {
      print(utf8.decode(response.bodyBytes));
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
              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
        });
    if (response.statusCode == 200) {
      final List<dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      final TimeIntervalListModel jsonToTimeIntervalListModel =
          TimeIntervalListModel.fromJson(decodeJsonData);
      return Future<TimeIntervalListModel>.value(jsonToTimeIntervalListModel);
    } else {
      print(utf8.decode(response.bodyBytes));
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
              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
        });
    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      final List<dynamic> decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      final WorkplaceListModel favoritesPlaceListModel =
          WorkplaceListModel.fromJson(decodeJsonData);
      return Future<WorkplaceListModel>.value(favoritesPlaceListModel);
    } else {
      print(response.statusCode);
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
              'Basic ${base64.encode(utf8.encode('$username:$password'))}'
        });
    if (response.statusCode == 200) {
      final String decodeJsonData = utf8.decode(response.bodyBytes);
      final String answer = decodeJsonData;
      return Future<String>.value(answer);
    } else {
      print((utf8.decode(response.bodyBytes)));
      throw ServerException();
    }
  }

  @override
  Future<String> postFavorite(int id) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final int body = id;
    final http.Response response =
        await client.post(Uri.parse('$BASE_URL/favPlace/'),
            headers: <String, String>{
              HttpHeaders.authorizationHeader:
                  'Basic ${base64.encode(utf8.encode('$username:$password'))}'
            },
            body: body);
    if (response.statusCode == 200) {
      final String decodeJsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as String;
      final String answer = decodeJsonData;
      return Future<String>.value(answer);
    } else {
      print((utf8.decode(response.bodyBytes)));
      throw ServerException();
    }
  }

  @override
  Future<String> postOffice(OfficeModel office) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final String body = json.encode(office.toJson()) ;
    print(body);
    final http.Response response = await client.post(
        Uri.parse('$BASE_URL/office/'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}',
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: body
    );
    if (response.statusCode == 200) {
      final String decodeJsonData =
      utf8.decode(response.bodyBytes);
      return Future<String>.value(decodeJsonData);
    } else {
      print(utf8.decode(response.bodyBytes));
      throw ServerException();
    }

  }

  @override
  Future<String> postFloors(List<MiniFloor> floors) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    print(floors.first.workplaces.length);
    for(final MiniFloor f in floors){
      final String body = json.encode(FloorModel.fromMini(f).toJson());
      print(body);
      final http.Response response = await client.post(
          Uri.parse('$BASE_URL/floor/'),
          headers: <String, String>{
            HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}',
            HttpHeaders.contentTypeHeader: 'application/json'
          },
          body: body
      );
      if (response.statusCode == 200) {
        f.setWorkplaces();
        final String decodeJsonData =
        utf8.decode(response.bodyBytes);
        print(decodeJsonData);
        final int nFloorId = int.parse(decodeJsonData);
        for(MiniWorkplace p in f.meetingRooms){
          final String body = json.encode(WorkplaceModel.fromMini(p, nFloorId).toJson());
          final http.Response response = await client.post(
              Uri.parse('$BASE_URL/workplace/'),
              headers: <String, String>{
                HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}',
                HttpHeaders.contentTypeHeader: 'application/json'
              },
              body: body
          );
          if(response.statusCode == 200) {
            final String decodeJsonData =
            utf8.decode(response.bodyBytes);
            print(decodeJsonData);
          }
          else{
            print(utf8.decode(response.bodyBytes));
            throw ServerException();
          }
        }
        for(MiniWorkplace p in f.workplaces){
          final String body = json.encode(WorkplaceModel.fromMini(p, nFloorId).toJson());
          final http.Response response = await client.post(
              Uri.parse('$BASE_URL/workplace/'),
              headers: <String, String>{
                HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}',
                HttpHeaders.contentTypeHeader: 'application/json'
              },
              body: body
          );
          if(response.statusCode == 200) {
            final String decodeJsonData =
            utf8.decode(response.bodyBytes);
            print(decodeJsonData);
          }
          else{
            print(utf8.decode(response.bodyBytes));
            throw ServerException();
          }
        }
      } else {
        print(utf8.decode(response.bodyBytes));
        throw ServerException();
      }

    }
    return Future<String>.value('Вроде успех');

  }

  @override
  Future<WorkplaceListModel> getWorkplacesByFloor(int floorId, int typeId) async {
    final SharedPreferences sharedPreference = di.sl();
    final String? username = sharedPreference.getString('username');
    final String? password = sharedPreference.getString('password');
    final http.Response response = await client.get(
        Uri.parse('$BASE_URL/workplace/allByFloor?floorId=$floorId&typeId=$typeId&page=0&size=20'),
        headers: <String, String>{HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('$username:$password'))}'});
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJsonData =
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final WorkplaceListModel jsonToFloorListModel = WorkplaceListModel.fromJson(decodeJsonData['content'] as List<dynamic>);
      return Future<WorkplaceListModel>.value(jsonToFloorListModel);
    } else {
      throw ServerException();
    }
  }


}

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import 'hive.dart';
import 'record.dart';

class ApiClient {
  static ApiClient? _instance;
  final dio = Dio(BaseOptions(
      baseUrl: "http://192.168.50.214:2000", //?? "http://hs.lantain.org",
      responseType: ResponseType.json));
  String? authToken;
  Auth auth = Auth();

  Future<void> login() async {
    if (auth.currentUser == null) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      authToken = token;
    } else {
      final idToken = await auth.currentUser?.getIdToken();
      final response = await dio.post('/auth', data: {'idToken': idToken});
      authToken = response.data['token'];
      prefs.setString('token', authToken!);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await auth.logout();
  }

  Future<List<Hive>> getHives() async {
    final response = await dio.get<List>('/hives',
        options: Options(headers: {'Authorization': "Bearer $authToken"}));
    return response.data!.map((i) => Hive.fromServerResponse(i)).toList();
  }

  Future<Hive> getHive(String hiveId) async {
    final response = await dio.get('/hives/$hiveId',
        options: Options(headers: {'Authorization': "Bearer $authToken"}));
    return Hive.fromServerResponse(response.data);
  }

  Future<List<Record>> getRecords(String hiveId, int limit, int offset) async {
    final response = await dio.get<List>(
        '/hives/$hiveId/records?limit=$limit&offset=$offset',
        options: Options(headers: {'Authorization': "Bearer $authToken"}));
    return response.data!.map((i) => Record.fromServerResponse(i)).toList();
  }

  Future<void> addHiveToUser(String hiveId) async {
    final response = await dio.post('/hives/$hiveId/connect',
        options: Options(headers: {'Authorization': "Bearer $authToken"}));
  }

  static Future<ApiClient> getInstance() async {
    if (_instance == null) {
      _instance = ApiClient();
      await _instance!.login();
    }
    return _instance!;
  }
}

part of 'data.dart';

class JastisApi {
  static Dio dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.15:8000/api',
    // baseUrl: 'http://192.168.1.180:8000/api',
    connectTimeout: const Duration(minutes: 1).inMilliseconds,
    receiveTimeout: const Duration(minutes: 1).inMilliseconds,
  ));

  static String? token;

  static setAuthToken(String token) {
    JastisApi.token = token;
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
}

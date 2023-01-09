part of 'data.dart';

class AuthApi {
  static const String _urlPrefix = '/auth';

  static Future<ResponseModel<UserModel>> login(Map loginInfo) async {
    ResponseModel<UserModel> response = ResponseModel<UserModel>();
    try {
      var result = await JastisApi.dio.post('$_urlPrefix/login', data: {
        'email': loginInfo['email'],
        'password': loginInfo['password'],
      });
      response = ResponseModel.fromJson(result.data);
      if (response.success) {
        response.data = UserModel.fromJson(result.data['data']['user']);
        JastisApi.setAuthToken(response.token!);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        response = ResponseModel<UserModel>.fromJson(e.response?.data);
      }
    } catch (e) {
      rethrow;
    }

    return response;
  }

  static Future<ResponseModel<UserModel>> register(Map loginInfo) async {
    ResponseModel<UserModel> response = ResponseModel<UserModel>();
    try {
      var result = await JastisApi.dio.post('$_urlPrefix/register', data: {
        'name': loginInfo['name'],
        'email': loginInfo['email'],
        'password': loginInfo['password'],
      });
      response = ResponseModel.fromJson(result.data);
      if (response.success) {
        response.data = UserModel.fromJson(result.data['data']['user']);
        JastisApi.setAuthToken(response.token!);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        response = ResponseModel<UserModel>.fromJson(e.response?.data);
      }
    } catch (e) {
      rethrow;
    }

    return response;
  }

  static Future<ResponseModel> logout() async {
    ResponseModel response = ResponseModel();
    try {
      var result = await JastisApi.dio.post('$_urlPrefix/logout');
      response = ResponseModel.fromJson(result.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        response = ResponseModel<UserModel>.fromJson(e.response?.data);
      }
    } catch (e) {
      rethrow;
    }

    return response;
  }

  static Future<ResponseModel<UserModel>> refreshToken(String token) async {
    ResponseModel<UserModel> response = ResponseModel<UserModel>();
    try {
      var result = await JastisApi.dio.post('$_urlPrefix/refresh');
      response = ResponseModel.fromJson(result.data);
      if (response.success) {
        response.data = UserModel.fromJson(result.data['data']['user']);
        JastisApi.setAuthToken(response.token!);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        response = ResponseModel<UserModel>.fromJson(e.response?.data);
      }
    } catch (e) {
      rethrow;
    }

    return response;
  }
}

part of 'data.dart';

class UserApi {
  static const String _urlPrefix = '/user';

  static Future<ResponseModel<List<LectureModel>>> getLectures() async {
    ResponseModel<List<LectureModel>> response =
        ResponseModel<List<LectureModel>>();

    try {
      var result = await JastisApi.dio.get(
        '$_urlPrefix/lecture',
      );
      response = ResponseModel.fromJson(result.data);
      if (response.success) {
        response.data = result.data['data']
            .map<LectureModel>((data) => LectureModel.fromJson(data))
            .toList();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        response = ResponseModel.fromJson(e.response?.data);
      }
    } catch (e) {
      rethrow;
    }

    return response;
  }

  static Future<ResponseModel> joinLecture(Map joinInfo) async {
    ResponseModel response = ResponseModel();

    try {
      var result = await JastisApi.dio.post(
        '$_urlPrefix/join',
        data: {
          'code': joinInfo['code'],
        },
      );

      response = ResponseModel.fromJson(result.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        response = ResponseModel.fromJson(e.response?.data);
      } else if (e.response?.statusCode == 404) {
        response = ResponseModel.fromJson({
          'success': false,
          'message': 'Lecture not found',
        });
      }
    } catch (e) {
      rethrow;
    }

    return response;
  }

  static Future<ResponseModel> leaveLecture(LectureModel lecture) async {
    ResponseModel response = ResponseModel();

    try {
      var result = await JastisApi.dio.delete(
        '$_urlPrefix/leave',
        data: {
          'code': lecture.code,
        },
      );

      response = ResponseModel.fromJson(result.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        response = ResponseModel.fromJson(e.response?.data);
      }
    } catch (e) {
      rethrow;
    }

    return response;
  }
}

part of 'controllers.dart';

class LectureController extends GetxController {
  final store = GetStorage();
  static LectureController to = Get.find();

  var codeController = TextEditingController();

  final _listLectures = <LectureModel>[].obs;
  final _teachingLectures = <LectureModel>[].obs;
  final _learningLectures = <LectureModel>[].obs;

  final _isLoadingLecture = false.obs;
  final _valMsg = ''.obs;

  List get listLectures => _listLectures.value;
  List get teachingLectures => _teachingLectures.value;
  List get learningLectures => _learningLectures.value;
  bool get isLoadingLecture => _isLoadingLecture.value;
  String get valMsg => _valMsg.value;

  Future<ResponseModel<List<LectureModel>>> getLectures(
      BuildContext context) async {
    ResponseModel<List<LectureModel>> response =
        ResponseModel<List<LectureModel>>();
    _isLoadingLecture.value = true;

    try {
      response = await UserApi.getLectures();

      if (response.success) {
        _listLectures.value = response.data;

        _teachingLectures.value = List<LectureModel>.from(
            response.data.where((e) => e.role == 'lecturer'));
        _learningLectures.value = List<LectureModel>.from(
            response.data.where((e) => e.role == 'student'));
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error on get Lectures',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } finally {
      _isLoadingLecture.value = false;
    }

    return response;
  }

  Future<ResponseModel> joinLecture(BuildContext context) async {
    ResponseModel response = ResponseModel();

    context.loaderOverlay.show();
    try {
      response = await UserApi.joinLecture({
        'code': codeController.text.trim(),
      });

      if (response.success) {
        getLectures(context);
        clearFieldController();
      } else {
        _valMsg.value = response.message;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error on joinLecture',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(.6),
        colorText: Colors.white,
      );
    } finally {
      context.loaderOverlay.hide();
    }

    return response;
  }

  Future<ResponseModel> leaveLecture(
      BuildContext context, LectureModel lecture) async {
    ResponseModel response = ResponseModel();

    // context.loaderOverlay.show();
    _isLoadingLecture.value = true;
    try {
      response = await UserApi.leaveLecture(lecture);

      if (response.success) {
        getLectures(context);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error on leaveLecture',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(.6),
        colorText: Colors.white,
      );
    } finally {
      // context.loaderOverlay.hide();
      _isLoadingLecture.value = false;
    }

    return response;
  }

  //Sign out
  void clearFieldController() {
    codeController.clear();

    _valMsg.value = '';
  }
}

part of 'controllers.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  final store = GetStorage();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _user = Rxn<UserModel>();
  var token = ''.obs;
  var valMsg = ''.obs;

  @override
  void onInit() async {
    var userString = await store.read('user');
    if (userString != null) {
      _user.value = UserModel.fromJson(userString);
      token.value = await store.read('token');
      JastisApi.setAuthToken(token.value);
    }
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.onClose();
  }

  UserModel? get user => _user.value;

  Future<ResponseModel<UserModel>> register(BuildContext context) async {
    ResponseModel<UserModel> response = ResponseModel<UserModel>();

    context.loaderOverlay.show();
    try {
      response = await AuthApi.register({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      });
      if (response.success) {
        await store.write('token', response.token);
        await store.write('user', response.data.toJson());

        _user.value = response.data;

        clearFieldController();
      } else {
        valMsg.value = response.message;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error on register',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } finally {
      await Future.delayed(const Duration(seconds: 2))
          .then((value) => context.loaderOverlay.hide());
    }

    return response;
  }

  //Method to handle user sign in using email and password
  Future<ResponseModel<UserModel>> login(BuildContext context) async {
    ResponseModel<UserModel> response = ResponseModel<UserModel>();

    context.loaderOverlay.show();
    try {
      response = await AuthApi.login({
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      });
      if (response.success) {
        emailController.clear();
        passwordController.clear();

        await store.write('token', response.token);
        await store.write('user', response.data.toJson());

        _user.value = response.data;

        clearFieldController();
      } else {
        valMsg.value = response.message;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error on signin',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } finally {
      await Future.delayed(const Duration(seconds: 2))
          .then((value) => context.loaderOverlay.hide());
    }

    return response;
  }

  Future<ResponseModel> logout(BuildContext context) async {
    ResponseModel response = ResponseModel();

    clearFieldController();

    context.loaderOverlay.show();
    try {
      response = await AuthApi.logout();

      if (response.success) {
        await store.remove('token');
        await store.remove('user');
      } else {
        valMsg.value = response.message;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error on logout',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } finally {
      await Future.delayed(const Duration(seconds: 2))
          .then((value) => context.loaderOverlay.hide());
    }

    return response;
  }

  Future<bool> refreshToken() async {
    ResponseModel<UserModel> response = ResponseModel<UserModel>();
    bool result = false;
    try {
      var token = await store.read('token');
      JastisApi.setAuthToken(token);
      response = await AuthApi.refreshToken(token);
      if (response.success) {
        result = true;
        await store.write('token', response.token);
        await store.write('user', response.data.toJson());
      }
    } catch (e) {
      /// TODO refreshToken catchHandler
    }

    return result;
  }

  //Sign out
  void clearFieldController() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();

    valMsg.value = '';
  }
}

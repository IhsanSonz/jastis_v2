part of 'middlewares.dart';

class AuthMiddleware extends GetMiddleware {
  final store = GetStorage();
  final AuthController _authc = AuthController.to;

  @override
  RouteSettings? redirect(String? route) {
    return _authc.user != null ? null : const RouteSettings(name: '/login');
  }
}

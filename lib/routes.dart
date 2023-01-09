import 'package:get/get.dart';
import 'package:jastis_v2/middlewares/middlewares.dart';
import 'package:jastis_v2/pages/pages.dart';

final appPages = [
  GetPage(
    name: '/',
    page: () => const SplashPage(),
  ),
  GetPage(
    name: '/login',
    page: () => const LoginPage(),
  ),
  GetPage(
    name: '/register',
    page: () => const RegisterPage(),
  ),
  GetPage(
    name: '/home',
    page: () => const MainTabPage(),
    middlewares: [
      AuthMiddleware(),
    ],
  ),
];

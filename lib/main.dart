import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jastis_v2/controllers/controllers.dart';
import 'package:jastis_v2/routes.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:get/get.dart';

void main() async {
  await GetStorage.init();

  Get.put<AuthController>(AuthController());
  Get.put<MenuController>(MenuController());

  Get.put<LectureController>(LectureController());

  var refresh = await AuthController().refreshToken();
  if (!refresh) {
    await GetStorage().remove('user');
    await GetStorage().remove('token');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter GetX',
        getPages: appPages,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Color(0xFF5E5454),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            headline2: TextStyle(
              color: Color(0xFF5E5454),
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            caption: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            subtitle1: TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
            subtitle2: TextStyle(
              color: Colors.black,
              fontSize: 8,
            ),
          ),
        ),
        initialRoute: '/home',
      ),
    );
  }
}

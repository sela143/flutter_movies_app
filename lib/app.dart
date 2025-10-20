import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/home_controller.dart';
import 'package:movies_app/routes/app_route.dart';
import 'package:movies_app/view/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(HomeController());
    return GetMaterialApp(
      theme: themeController.lightTheme,
      darkTheme: themeController.darkTheme,
      themeMode: themeController.themeMode.value,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: AppRoute.splash,
      getPages: AppRoute.pages,
      home: HomeScreen(),
    );
  }
}


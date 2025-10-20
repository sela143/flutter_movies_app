import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/controller/home_controller.dart';
import 'package:movies_app/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final controller = Get.put(SplashController());
  final themeCtl = Get.find<HomeController>();
    SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeCtl.isDarkMode? Colors.black : Colors.white,
      body: Center(
            child: Lottie.asset(
              "assets/animation/logo.json",
              width: 300,
              height: 300,
              repeat: true,
              animate: true,
              fit: BoxFit.contain,
            ),
          ),
    );

  }
}

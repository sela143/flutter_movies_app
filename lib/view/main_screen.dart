import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/main_controller.dart';
import 'package:movies_app/view/home_screen.dart';
import 'package:movies_app/view/profile_screen.dart';
import 'package:movies_app/widget/bottom_navigation_bar_widget.dart';

class MainScreen extends StatelessWidget {
  final controller = Get.put(MainController());
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      HomeScreen(),
      ProfileScreen()
    ];
    return Obx(() => Scaffold(
          body: screen[controller.getSelectIndex],
          bottomNavigationBar: _buildBottomNavigationBar,
        ));
  }

  get _buildBottomNavigationBar {
    return BottomNavigationBarWidget(
      onChange: (index) => controller.changeIndex(index),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/bottom_navigetion_controller.dart';
import 'package:movies_app/controller/home_controller.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final themeCtl = Get.find<HomeController>();
  final controller = Get.put(BottomNavigetionController());
  final void Function(int)? onChange;

  BottomNavigationBarWidget({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: EdgeInsets.only(bottom: 20),
          color: themeCtl.isDarkMode ? Colors.black : Colors.white,
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(controller.icons.length, (index) {
              final isSelected = controller.selectedIndex == index;
              return GestureDetector(
                onTap: (){
                  controller.selectedIndex = index;
                  onChange!(index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  height: isSelected ? 60 : 50,
                  width: isSelected ? 60 : 50,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.red : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 250),
                scale: isSelected ? 1.2 : 1.0,
                curve: Curves.easeInOut,
                child: Icon(
                  controller.icons[index],
                  size: 25,
                  color: isSelected ? Colors.white : Colors.grey,
                ),
                )
              ),
              );
            }),
          ),
        ));
  }
}

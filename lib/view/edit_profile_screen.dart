import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/home_controller.dart';
import 'package:movies_app/controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final themeCtl = Get.find<HomeController>();
  final controller = Get.put(ProfileController());
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: themeCtl.isDarkMode ? Colors.black : Colors.white,
        appBar: _buildAppBar,
        body: _buildBody,
      ),
    );
  }

  get _buildAppBar {
    return AppBar(
      backgroundColor: themeCtl.isDarkMode ? Colors.black : Colors.white,
      titleSpacing: 0,
      title: Text(
        "Edit Profile",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
          )),
    );
  }

  get _buildBody {
    final borderColor = themeCtl.isDarkMode;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Obx((){
        return Column(
        spacing: 20,
        children: [
          TextField(
              controller: controller.nameCtl,
              onChanged: (value) {
                controller.name.value = value;
              },
              decoration: InputDecoration(
                hintText: controller.name.value,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: borderColor ? Colors.white : Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: borderColor ? Colors.white : Colors.black)),
              )),
          SizedBox(
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  controller.setName(controller.nameCtl.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: controller.isLoading.value
                    ? CircularProgressIndicator()
                    : Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
          )
        ],
      );
      })
    );
  }
}

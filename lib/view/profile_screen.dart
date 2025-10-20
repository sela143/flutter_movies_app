import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/home_controller.dart';
import 'package:movies_app/controller/profile_controller.dart';
import 'package:movies_app/view/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());
  final themeCtl = Get.find<HomeController>();
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeCtl.isDarkMode ? Colors.black : Colors.white,
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  get _buildAppBar {
    return AppBar(
      backgroundColor: themeCtl.isDarkMode ? Colors.black : Colors.white,
      title: Text(
        "Profile",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              controller.signOut();
            },
            child: Text(
              "SignOut",
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
  }

  get _buildBody {
    return SafeArea(
      child: Center(
        child: Obx(() => Column(
                  spacing: 10,
                  children: [
                    GestureDetector(
                      onTap: (){
                        controller.uploadImage();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey, borderRadius: BorderRadius.circular(15),
                            
                            ),
                        child: controller.isLoading.value?
                         Center(
                            child: SizedBox(
                              height: 40, // control size of the spinner
                              width: 40,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : controller.imageUrl.isNotEmpty
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                  controller.imageUrl.value,
                                  fit: BoxFit.cover,
                                ),
                            )
                            : Center(
                              child: Icon(
                                  Icons.camera_alt,
                                  size: 35,
                                ),
                            ),
                      ),
                    ),
                    Text(
                          "${controller.name}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                    GestureDetector(
                      onTap: () => Get.to(EditProfileScreen()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Text(
                            "Edit",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.blueAccent,
                          )
                        ],
                      ),
              )],
                ),
           ),
      ),
    );
  }
}

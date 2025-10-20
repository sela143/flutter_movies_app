import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/home_controller.dart';
import 'package:movies_app/controller/profile_controller.dart';
import 'package:movies_app/view/search_screen.dart';
import 'package:movies_app/widget/popular_movie_widget.dart';
import 'package:movies_app/widget/top_rated_movie.dart';
import 'package:movies_app/widget/upcoming_movie.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());
  final homeController = Get.put(ProfileController());
  final profileCtl = Get.find<ProfileController>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: controller.isDarkMode ? Colors.black : Colors.white,
          appBar: _buildAppBar,
          body: _buildBody,
        ));
  }

  get _buildAppBar {
    return AppBar(
      backgroundColor: controller.isDarkMode ? Colors.black : Colors.white,
      title: Obx(() => Row(
            spacing: 10,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey,),
                child: profileCtl.imageUrl.value.isEmpty? Icon(Icons.person)
                : Image.network(profileCtl.imageUrl.value, fit: BoxFit.cover,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back!",
                    style: TextStyle(fontSize: 16),
                  ),
                  homeController.name.value.isNotEmpty?
                  Text(homeController.name.value,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                : Text("User", 
                        style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),)
                ],
              ),
            ],
          )),
      actions: [
        Row(
          spacing: 20,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(SearchScreen());
              },
              child: Container(
                width: 100,
                height: 45,
                decoration: controller.isDarkMode
                    ? BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(20))
                    : BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    Text(
                      "Search",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                controller.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                size: 30,
                color: controller.isDarkMode ? Colors.yellow : Colors.black,
              ),
              onPressed: controller.toggleTheme,
            ),
          ],
        ),
      ],
    );
  }

  get _buildBody {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
        child: ListView(
          children: [
            Column(
              spacing: 20,
              children: [
                // TypeMovieWidget(),
                PopularMovieWidget(),
                UpcomingMovie(),
                TopRatedMovie()
              ],
            ),
          ],
        ));
  }
}

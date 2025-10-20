import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/upcoming_movie_controller.dart';
import 'package:movies_app/view/movie_detail_screen.dart';

class UpcomingMovie extends StatelessWidget {
  final controller = Get.put(UpcomingMovieController());
  UpcomingMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Upcoming",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              "see all",
              style: TextStyle(fontSize: 15, color: Colors.blue),
            ),
          ],
        ),
        SizedBox(
            height: 350,
            child: Obx(() {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.upcomingMovie.length,
                  itemBuilder: (context, index) {
                    final data = controller.upcomingMovie[index];
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.only(left: 2, right: 10),
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(MovieDetailScreen(movieId: data.id as int)),
                            child: Container(
                              height:250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w500${data.posterPath}"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data.title}",maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${data.releaseDate}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }))
      ],
    );
  }
}

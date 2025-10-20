import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/top_rated_movie_controller.dart';
import 'package:movies_app/view/movie_detail_screen.dart';

class TopRatedMovie extends StatelessWidget {
  final controller = Get.put(TopRatedMovieController());

  TopRatedMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Top Rated Movie",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("See All",
                style: TextStyle(fontSize: 15, color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 10),
        Obx(() {
          if (controller.isLoading.value) {
            return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()));
          }

          if (controller.topRatedMovie.isEmpty) {
            return const SizedBox(
                height: 200, child: Center(child: Text("No similar movies",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                )));
          }

          return SizedBox(
            height: 315,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.topRatedMovie.length,
              itemBuilder: (context, index) {
                final data = controller.topRatedMovie[index];
                return Container(
                  width: 150,
                  margin: const EdgeInsets.only(left: 5, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.posterPath == null
                          ? Container(
                              height: 240,
                              color: Colors.grey[300],
                              child: const Center(
                                  child: Icon(Icons.movie, size: 50)),
                            )
                          : GestureDetector(
                              onTap: () {
                                Get.to(MovieDetailScreen(
                                    movieId: data.id ?? 0));
                              },
                              child: Container(
                                height: 240,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w200${data.posterPath}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 5),
                      Text(
                        data.title ?? "",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                      Text(
                        data.releaseDate ?? "",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

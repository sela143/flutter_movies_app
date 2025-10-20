import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/movie_detail_controller.dart';

class MovieActorWidget extends StatelessWidget {
  final int movieId;
  final movieDetailCtl = Get.find<MovieDetailController>();
   MovieActorWidget({super.key, required this.movieId}){
    movieDetailCtl.fetchActorMovie(movieId);
  }

  @override
  Widget build(BuildContext context) {
    return  Obx(() {
    if (movieDetailCtl.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (movieDetailCtl.actors.isEmpty) {
      return const Text("No actors found");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Actors",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // make it horizontal
            itemCount: movieDetailCtl.actors.length,
            itemBuilder: (context, index) {
              final actor = movieDetailCtl.actors[index];
              final imagePath = actor['profile_path'];
              final imageUrl = imagePath != null
                  ? "https://image.tmdb.org/t/p/w200$imagePath"
                  : "https://via.placeholder.com/150";

              return Container(
                width: 100,
                margin: EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl,
                        height: 130,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                     SizedBox(height: 5),
                    Text(
                      actor['name'] ?? 'Unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      actor['character'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  });
  }
}
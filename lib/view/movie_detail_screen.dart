import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/components/star_rating.dart';
import 'package:movies_app/controller/favorite_controller.dart';
import 'package:movies_app/controller/home_controller.dart';
import 'package:movies_app/controller/movie_detail_controller.dart';
import 'package:movies_app/widget/movie_actor_widget.dart';
import 'package:movies_app/widget/similar_movie_widget.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;
  final controller = Get.put(MovieDetailController());
  final homeController = Get.find<HomeController>();
  // final favoriteCtl = Get.put(FavoriteController());
  final favoriteCtl = Get.find<FavoriteController>();
  MovieDetailScreen({super.key, required this.movieId}) {
    controller.fetchMovieDetail(movieId);
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchMovieDetail(movieId);
    return Scaffold(
      backgroundColor: homeController.isDarkMode ? Colors.black : Colors.white,
      body: _buildBody,
    );
  }

  get _buildBody {
    return CustomScrollView(slivers: [_buildAppbar, _buildList]);
  }

  get _buildAppbar {
    return SliverAppBar(
      expandedHeight: 350,
      flexibleSpace: FlexibleSpaceBar(
          background: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Image.network(
                  "https://image.tmdb.org/t/p/w500${controller.movieDetail['backdrop_path']}",
                  fit: BoxFit.fill,
                ))),
      leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          )),
    );
  }

  get _buildList {
    return SliverToBoxAdapter(
      child: Obx(() {
        final data = controller.movieDetail;
        final isFav = favoriteCtl.isFavoriteMovie(data['id'] ?? 0);
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 10,
                children: [
                  Expanded(
                      child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: homeController.isDarkMode
                            ? Colors.white.withValues(alpha: 0.6)
                            : Colors.grey[400],
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.black,
                        ),
                        Text(
                          "Triler",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue[600],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.movie_filter_sharp,
                              color: Colors.white,
                            ),
                            Text(
                              "Watch Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )),
                ],
              ),
              Row(
                spacing: 15,
                children: [
                  Container(
                    clipBehavior: Clip.none,
                    height: 40,
                    decoration: BoxDecoration(
                        color: isFav ? Colors.red : Colors.grey[850],
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: GestureDetector(
                        onTap: (){
                          if(isFav){
                            favoriteCtl.removeFavoriteMovie(data['id'] ?? 0);
                          }else{
                            favoriteCtl.addFavoriteMovie(Map<String, dynamic>.from(data));
                          }
                        },
                        child: Row(
                          spacing: 5,
                          children: [
                            Text(
                              "Favorite",
                              style:isFav? TextStyle(fontWeight: FontWeight.bold) : TextStyle(color:Colors.white),
                            ),
                            Icon(
                               isFav? Icons.favorite : Icons.favorite_border,
                              size: 20,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.none,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        spacing: 5,
                        children: [
                          Text(
                            "Share",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.share,
                            size: 20,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.none,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        spacing: 5,
                        children: [
                          Text(
                            "Download",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.download_sharp,
                            size: 20,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(data['title'] ?? "",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(data['release_date'] ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    spacing: 5,
                    children: [
                      StarRating(
                          voteAverage: data['vote_average']?.toDouble() ?? 0),
                      Text(
                        '(${data['vote_count']})',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  Text("StoryLine",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(data['overview'] ?? "", style: TextStyle(fontSize: 15)),
                ],
              ),
              MovieActorWidget(
                movieId: movieId,
              ),
              SimilarMovieWidget(movieId: movieId)
            ],
          ),
        );
      }),
    );
  }
}

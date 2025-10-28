import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/components/star_rating.dart';
import 'package:movies_app/controller/favorite_controller.dart';
import 'package:movies_app/controller/home_controller.dart';
import 'package:movies_app/view/movie_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  final favoriteCtl = Get.find<FavoriteController>();
  final homeClt = Get.find<HomeController>();
   FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeClt.isDarkMode ? Colors.black : Colors.white,
      appBar: _buildAppBar, 
      body: _buildBody,
    );
  }

  get _buildAppBar{
    return AppBar(
      backgroundColor: homeClt.isDarkMode ? Colors.black : Colors.white,
      centerTitle: true,
      title: Text("Favorite",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  get _buildBody{
    return Obx((){
      if(favoriteCtl.favoriteMovies.isEmpty){return Center(child: Text("No favorite movies", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),));}
      return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: ListView.builder(
          itemCount: favoriteCtl.favoriteMovies.length,
          itemBuilder: (context, indext){
          final data = favoriteCtl.favoriteMovies[indext];
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () => Get.to(MovieDetailScreen(movieId: data['id'])),
                    child: Container(
                      padding: EdgeInsets.zero,
                    clipBehavior: Clip.hardEdge,
                      height: 200,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)
                      ),
                    child: Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: Container(
                            height: Get.height,
                            // width: 135,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage("https://image.tmdb.org/t/p/w500${data['poster_path']}"), fit: BoxFit.cover)
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['title'] ?? "",
                                  maxLines: 1,
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
                              GestureDetector(
                                onTap: (){
                                  favoriteCtl.removeFavoriteMovie(data['id']);
                                },
                                child: Icon(Icons.favorite, color: Colors.red,size: 30,))
                            ],
                          ),
                        )
                      ],
                    ),
                    ),
                  ),
                )
              ],
            );
          }),
      ),
    );
    });
  }
}
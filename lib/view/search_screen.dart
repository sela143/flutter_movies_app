import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/components/star_rating.dart';
import 'package:movies_app/controller/home_controller.dart';
import 'package:movies_app/controller/search_moive_controller.dart';
import 'package:movies_app/controller/type_movie_controller.dart';
import 'package:movies_app/view/movie_detail_screen.dart';
import 'package:movies_app/widget/type_movie_widget.dart';

class SearchScreen extends StatelessWidget {
  final controller = Get.put(SearchMoiveController());
  final filterMoive = Get.put(TypeMovieController());
  final thrmeCtl = Get.find<HomeController>();
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: thrmeCtl.isDarkMode ? Colors.black : Colors.white,
          appBar: _buildAppBar,
          body: _buildBody,
        ));
  }

  get _buildAppBar {
    return AppBar(
      backgroundColor: thrmeCtl.isDarkMode ? Colors.black : Colors.white,
      toolbarHeight: 80,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(right: 10,),
        child: SearchBar(
          controller: controller.searchCtl,
          onChanged: (query) => controller.searchMoive(query),
          autoFocus: true,
          hintText: "Search for a movie",
          hintStyle:
              WidgetStateProperty.all(TextStyle(color: Colors.grey[600])),
        ),
      ),
      leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 30,
          )),
      bottom: PreferredSize(
        preferredSize: Size(0, 70),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: TypeMovieWidget(),
        ),
      ),
    );
  }

  get _buildBody {
    return Obx((){
      if (controller.isLoading.value || filterMoive.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
      }
        if(controller.searchCtl.text.isEmpty){
          if(filterMoive.filterMovie.isEmpty){
            return const Center(child: Text("Search for a movie",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),
          ));}
          return _movieList(filterMoive.filterMovie);
        }
          if (controller.searchResults.isEmpty) {
          return const Center(child: Text("No movies found",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),
          ));
          }
      return _movieList(controller.searchResults);
    }); 
  }

  Widget _movieList(List movie){
    return SingleChildScrollView(
      child: GridView.builder(
        padding: EdgeInsets.only(left: 5, right: 5, top: 15),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 300,
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                childAspectRatio: 1,
              ),
          itemCount: movie.length,
          itemBuilder: (context, index){
          final data = movie[index];
            return GestureDetector(
              onTap: () => Get.to(MovieDetailScreen(movieId: data['id'])),
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 210,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                           "https://image.tmdb.org/t/p/w500${data['poster_path']}"
                        ))
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 2,
                        data['title'] ?? "",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(data['release_date'] ?? "",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                      StarRating(
                          voteAverage: data['vote_average']?.toDouble() ?? 0.0),
                    ],
                  )
                ],
              ),
            );
          } ,
        ),
    );
  }
}

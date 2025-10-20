import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/home_controller.dart';
import 'package:movies_app/view/movie_detail_screen.dart';

class PopularMovieWidget extends StatelessWidget {
  final controller = Get.find<HomeController>();
   PopularMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Popular",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )),
            Text("see all",
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue
              ),
            ),
          ],
        ),
        SizedBox(
          height: 315,
          child: Obx((){
            return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.movie.length,
            itemBuilder: (context, index){
              final data = controller.movie[index];
              return Container(
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.only(left: 2, right: 10),
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15)
                ),
                      
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    data.posterPath == null ? CircularProgressIndicator():
                    GestureDetector(
                      onTap: () {
                        Get.to(MovieDetailScreen(movieId: data.id as int));
                      },
                      child: Container(
                        height: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w500${data.posterPath}"),fit: BoxFit.cover)
                          ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${data.title}", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),maxLines: 2,),
                          Text("${data.releaseDate}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
          })
        )
      ],
    );
  }
}
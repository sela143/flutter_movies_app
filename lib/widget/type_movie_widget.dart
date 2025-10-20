import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/search_moive_controller.dart';
import 'package:movies_app/controller/type_movie_controller.dart';

class TypeMovieWidget extends StatelessWidget {
  final controller = Get.put(TypeMovieController());
  final searchController = Get.find<SearchMoiveController>();
  TypeMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.typeMovie.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: List.generate(controller.typeMovie.length, (index){
              final data = controller.typeMovie[index];
              return Obx((){ 
              final isSelect = controller.selectIndex.value == data['id'];
                return GestureDetector(
                    onTap: () {
                      // clear search bar when tapping genre
                      searchController.searchCtl.clear();
                      searchController.searchResults.clear();
                      controller.selectTypeMovie(index, data['id']);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 2, right: 10),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                        color: isSelect ? Colors.red : Colors.grey[600],
                      ),
                      child: Center(
                        child: Text(
                          data['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );}
                  );
              }),
            )
          ],
          
        ),
      );
    });  
  }
}

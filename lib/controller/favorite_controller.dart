import 'package:get/get.dart';

class FavoriteController extends GetxController{

   RxList<Map<String, dynamic>> favoriteMovies = <Map<String, dynamic>>[].obs;
final isLoading = false.obs;

   void addFavoriteMovie(Map<String, dynamic> movie) {
    if(!isFavoriteMovie(movie['id'])){
      favoriteMovies.add(movie);
    }
  }

  void removeFavoriteMovie(int id) {
    favoriteMovies.removeWhere((movie) => movie['id'] == id);
  }

  bool isFavoriteMovie(int id){
    return favoriteMovies.any((movie) => movie['id'] == id);
  }
  
}
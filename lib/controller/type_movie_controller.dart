import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TypeMovieController extends GetxController{
  final _apiKey = dotenv.env['API_KEY'];
  final _baseUrl = "https://api.themoviedb.org/3";
  var isLoading = false.obs;
  var typeMovie = [].obs;
  var selectIndex = 0.obs;
  var filterMovie = [].obs;

  @override
  void onInit() {
    fetchDataTypeMovie();
    super.onInit();
  }
  void selectTypeMovie(int id, int movieId, {VoidCallback? onGenreSelected}) {
    selectIndex.value = movieId; // store genreId instead of index
    fetchMoviesByGenre(movieId);
    // clear search text when a genre is selected
    if(onGenreSelected != null){
      onGenreSelected();
    } 
  }
  Future<void> fetchDataTypeMovie() async {
    try {
      final url = Uri.parse("$_baseUrl/genre/movie/list?api_key=$_apiKey");
      final response = await http.get(url);
      isLoading.value = true;
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final genres = List<Map>.from(data['genres']);
        typeMovie.value = genres;
      }
      isLoading.value = false;
    } catch (e) {
      debugPrint("Fetch error: $e");
    }
  }

  // Fetch movies by genre
  Future<void> fetchMoviesByGenre(int genreId) async {
    try {
      isLoading.value = true;
      String urlString;
      if (genreId == 0) {
        urlString = "$_baseUrl/movie/popular?api_key=$_apiKey";
      } else {
        urlString = "$_baseUrl/discover/movie?api_key=$_apiKey&with_genres=$genreId";
      }
      final url = Uri.parse(urlString);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        filterMovie.value = List<Map>.from(data['results']);
      }
      isLoading.value = false;
    } catch (e) {
      debugPrint("Fetch movies error: $e");
    }
  }
}
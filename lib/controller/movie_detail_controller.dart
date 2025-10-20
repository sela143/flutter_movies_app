import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MovieDetailController extends GetxController{
  final _apiKey = dotenv.env['API_KEY'];
  final _baseUrl = "https://api.themoviedb.org/3";
  final movieDetail =<String, dynamic>{}.obs;
  final similarMovies =<Map<String, dynamic>>[].obs;
  final actors = [].obs;
  var isLoading = false.obs;
  

  Future<void> fetchMovieDetail(int movieId) async{
    try {
      isLoading.value = true;
      movieDetail.clear();
      final url = Uri.parse("$_baseUrl/movie/$movieId?api_key=$_apiKey&language=en-US");
      final response = await http.get(url);
      movieDetail.value = jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> fetchActorMovie(int movieId) async{
    try {
      isLoading.value = true;
      final url = Uri.parse("$_baseUrl/movie/$movieId/credits?api_key=$_apiKey");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("Cast count: ${data['cast'].length}"); // 👈 check this
        actors.assignAll(data['cast'] ?? []);}
    } catch (e) {
      debugPrint(e.toString());
    } finally{
      isLoading.value = false;
    }
  }

  Future<void> fetchSimilarMovies(int movieId) async {
    try {
      isLoading.value = true;
      final url = Uri.parse(
          "$_baseUrl/movie/$movieId/similar?api_key=$_apiKey&language=en-US");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // store only results as list of maps
        similarMovies.value =
            List<Map<String, dynamic>>.from(data['results'] ?? []);
      } else {
        debugPrint("Error fetching similar movies: ${response.body}");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }


}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/model/movie_model.dart';

class TopRatedMovieController extends GetxController{
  final _apiKey = dotenv.env['API_KEY'];
  final _baseUrl = "https://api.themoviedb.org/3";
  var topRatedMovie = <Movie>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSimilarMovies();
  }
  Future<void> fetchSimilarMovies() async {
    try {
      final url = Uri.parse("$_baseUrl/movie/top_rated?api_key=$_apiKey");
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      final List results = data['results'];
      topRatedMovie.value = results.map((e)=> Movie.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
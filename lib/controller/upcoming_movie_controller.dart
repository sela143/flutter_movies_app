import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/model/movie_model.dart';

class UpcomingMovieController extends GetxController{
  final _apiKey = dotenv.env['API_KEY'];
  final _baseUrl = "https://api.themoviedb.org/3";
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchDataUpcomingMovie();
    super.onInit();
  }

  var upcomingMovie = <Movie>[].obs;
  Future<void> fetchDataUpcomingMovie() async{
    try {
      final url = Uri.parse("$_baseUrl/movie/upcoming?api_key=$_apiKey");
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      final List results = data['results'];
      upcomingMovie.value = results.map((e) => Movie.fromJson(e)).toList();// now this will be a list of Movie objects
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
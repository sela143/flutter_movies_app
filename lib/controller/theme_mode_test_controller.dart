
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:http/http.dart' as http;

class ThemeModeTestController extends GetxController {

  final _apiKey = dotenv.env['API_KEY'];
  final _baseUrl = "https://api.themoviedb.org/3";
  // Movie movie = Movie();
  var movie = <Movie>[].obs;
  Future<void> fetchData() async{
    try {
      final url = Uri.parse("$_baseUrl/movie/popular?api_key=$_apiKey");
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      final List results = data['results'];
      movie.value = results.map((e)=> Movie.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

}


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/controller/type_movie_controller.dart';

class SearchMoiveController extends GetxController{
  final _apiKey = dotenv.env['API_KEY'];
  final _baseUrl = "https://api.themoviedb.org/3";
  final searchCtl = TextEditingController();
  var isLoading = false.obs;
  var searchResults = [].obs;

  Future<void> searchMoive(String query) async{
    final typeController = Get.find<TypeMovieController>();
    // when user starts typing, clear genre selection
    if (query.isNotEmpty) {
      typeController.selectIndex.value = -1;
      typeController.filterMovie.clear();
    }

    if (query.isEmpty) {
        searchResults.clear();
        return;
      }
      
    isLoading.value = true;
    final url = Uri.parse("$_baseUrl/search/movie?api_key=$_apiKey&language=en-US&query=$query&page=1&include_adult=false");
    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      final List results = data['results'] ?? [];
      searchResults.value = results.map((e) => e).toList();
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}
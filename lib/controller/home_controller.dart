import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/services/local_service.dart';
import 'package:movies_app/theme/app_them.dart';
import 'package:http/http.dart' as http;
class HomeController extends GetxController{
  final _apiKey = dotenv.env['API_KEY'];
  final _baseUrl = "https://api.themoviedb.org/3";
  var isLoading = false.obs;

  final _storage = LocalStorageService.instan;
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  ThemeData get lightTheme => AppTheme.lightTheme;
  ThemeData get darkTheme => AppTheme.darkTheme;
  bool get isDarkMode => themeMode.value == ThemeMode.dark;
  void toggleTheme() {
    if (isDarkMode) {
      _setTheme(ThemeMode.light);
    } else {
      _setTheme(ThemeMode.dark);
    }
  }
  void _setTheme(ThemeMode mode){
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    _storage.setBool('isDarkMode', mode == ThemeMode.dark);
  }
  
  void _loadTheme() {
    final isDark = _storage.getBool('isDarkMode') ?? false;
    themeMode.value = isDark? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);
  }
  @override
  void onInit() {
    _loadTheme();
    fetchDataPopular();
    super.onInit();
  }
  // Movie movie = Movie();
  var movie = <Movie>[].obs;
  Future<void> fetchDataPopular() async{
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

}
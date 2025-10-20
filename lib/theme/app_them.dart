import 'package:flutter/material.dart';

class AppTheme {
  // 🔆 Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    // appBarTheme: AppBarTheme(color: Colors.white)
  );

  // 🌙 Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    // appBarTheme: AppBarTheme(color: Color(0xFF121212))
  );
}

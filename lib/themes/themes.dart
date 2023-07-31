import 'package:flutter/material.dart';

// Light mode theme
final lightThemeData = ThemeData(
  primarySwatch: Colors.blue, // Màu chủ đạo
  scaffoldBackgroundColor: Colors.white, // Màu nền của scaffold
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue, // Màu nền của app bar
    foregroundColor: Colors.white, // Màu văn bản trên app bar
    iconTheme: IconThemeData(color: Colors.white), // Màu biểu tượng trên app bar
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black), // Màu văn bản chung
  ),
);

// Dark mode theme
final darkThemeData = ThemeData(
  primarySwatch: Colors.blueGrey, // Màu chủ đạo
  scaffoldBackgroundColor: Colors.grey[900], // Màu nền của scaffold
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900], // Màu nền của app bar
    foregroundColor: Colors.white, // Màu văn bản trên app bar
    iconTheme: IconThemeData(color: Colors.white), // Màu biểu tượng trên app bar
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white), // Màu văn bản chung
  ),
);
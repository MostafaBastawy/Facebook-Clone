import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0.5,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
    ),
    titleTextStyle: TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 17.0,
    ),
  ),
);

ThemeData darkMode = ThemeData();

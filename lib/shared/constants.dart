import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.blue),
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
String defaultProfileImage = 'https://i.stack.imgur.com/l60Hf.png';
String defaultCoverImage =
    'http://vapeairways.com/wp-content/uploads/2016/04/dummy-post-horisontal-thegem-blog-default.jpg';
String defaultBio = 'Write your Bio...';

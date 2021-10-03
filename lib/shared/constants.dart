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
String defaultProfileImage =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNTmC3sqQmpaxRzTIz009mFt_AMzGYTs_w_VBVHyXPIOAmEP995kITocRkxX_Lm6V8ug0&usqp=CAU';
String defaultCoverImage =
    'https://socialsizes.io/static/facebook-cover-photo-size-eb6495646be79eea62423b216ac0b36b.jpg';
String defaultBio = 'Write your Bio...';

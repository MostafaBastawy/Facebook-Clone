import 'package:facebook_clone/cubit/bloc_observing.dart';
import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/screens/home_layout.dart';
import 'package:facebook_clone/screens/login_screen.dart';
import 'package:facebook_clone/shared/constants.dart';
import 'package:facebook_clone/shared/shared_prefrence.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp();
  String uid = CacheHelper.getData(key: 'uid') ?? '';
  Widget startScreen;
  uid.isNotEmpty ? startScreen = HomeLayout() : startScreen = LoginScreen();

  runApp(MyApp(
    startScreen: startScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startScreen;

  MyApp({this.startScreen});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getPosts()
        ..getStories(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.light,
        home: startScreen,
      ),
    );
  }
}

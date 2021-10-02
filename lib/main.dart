import 'package:facebook_clone/cubit/bloc_observing.dart';
import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/screens/login_screen.dart';
import 'package:facebook_clone/shared/constants.dart';
import 'package:facebook_clone/shared/shared_prefrence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.light,
        home: LoginScreen(),
      ),
    );
  }
}

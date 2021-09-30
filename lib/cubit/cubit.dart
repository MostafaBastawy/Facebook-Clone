import 'package:bloc/bloc.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/screens/chat_screen.dart';
import 'package:facebook_clone/screens/feeds_screen.dart';
import 'package:facebook_clone/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  List<String> titles = [
    'Facebook',
    'Chat',
    'Profile',
  ];
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];
  int currentIndex = 0;
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }
}

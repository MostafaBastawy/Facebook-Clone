import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/models/user_model.dart';
import 'package:facebook_clone/screens/chat_screen.dart';
import 'package:facebook_clone/screens/feeds_screen.dart';
import 'package:facebook_clone/screens/profile_screen.dart';
import 'package:facebook_clone/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    ProfileScreen(),
  ];
  int currentIndex = 0;
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(UserLoginSuccessfulState());
    }).catchError((error) {
      emit(UserLoginErrorState(error.toString()));
    });
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUserInDatabase(
        email: email,
        name: name,
        phone: phone,
      );
      emit(UserRegisterSuccessfulState());
    }).catchError((error) {
      emit(UserRegisterErrorState(error.toString()));
    });
  }

  void createUserInDatabase({
    required String name,
    required String email,
    required String phone,
  }) {
    UserDataModel userDataModel = UserDataModel(
      name,
      email,
      phone,
      defaultProfileImage,
      defaultCoverImage,
      defaultBio,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(userDataModel.toMap())
        .then((value) {
      emit(CreateUserSuccessfulState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
      print(error);
    });
  }
}

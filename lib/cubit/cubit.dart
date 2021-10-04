import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/models/user_model.dart';
import 'package:facebook_clone/screens/chat_screen.dart';
import 'package:facebook_clone/screens/feeds_screen.dart';
import 'package:facebook_clone/screens/profile_screen.dart';
import 'package:facebook_clone/shared/constants.dart';
import 'package:facebook_clone/shared/shared_prefrence.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
      getUserData();

      emit(UserLoginSuccessState());
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
      emit(UserRegisterSuccessState());
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
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      emit(UserSignOutSuccessState());
      CacheHelper.removeData(key: 'uid');
    }).catchError((error) {
      emit(UserSignOutErrorState(error.toString()));
    });
  }

  UserDataModel? userDataModel;
  void getUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userDataModel = UserDataModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
    required String bio,
    String? profileImage,
    String? coverImage,
  }) {
    UserDataModel userModel = UserDataModel(
      name,
      phone,
      email,
      bio,
      profileImage ?? userDataModel!.profileImage,
      coverImage ?? userDataModel!.coverImage,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickProfileImageSuccessState());
    } else {
      emit(PickProfileImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String email,
    required String phone,
    required String bio,
    String? coverImage,
    File? profileImage,
  }) {
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child('profileImage.jpg')
          .putFile(profileImage)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateUserData(
            name: name,
            email: email,
            phone: phone,
            bio: bio,
            coverImage: coverImage,
            profileImage: value,
          );
        }).catchError((error) {
          emit(UploadCoverImageErrorState(error));
        });
      }).catchError((error) {
        emit(UploadCoverImageErrorState(error));
      });
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(PickProfileImageSuccessState());
    } else {
      emit(PickProfileImageErrorState());
    }
  }

  void uploadCoverImage({
    required String name,
    required String email,
    required String phone,
    required String bio,
    String? profileImage,
    File? coverImage,
  }) {
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child('coverImage.jpg')
          .putFile(coverImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateUserData(
            name: name,
            email: email,
            phone: phone,
            bio: bio,
            coverImage: value,
            profileImage: profileImage,
          );
        }).catchError((error) {
          emit(UploadCoverImageErrorState(error));
        });
      }).catchError((error) {
        emit(UploadCoverImageErrorState(error));
      });
    }
  }
}

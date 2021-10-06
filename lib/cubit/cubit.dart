import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/models/post_model.dart';
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
      getPosts();

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
    required String phone,
    required String bio,
    String? email,
    String? profileImage,
    String? coverImage,
  }) {
    UserDataModel userModel = UserDataModel(
      name,
      email = userDataModel!.email,
      phone,
      profileImage = profileImageUrl ?? userDataModel!.profileImage,
      coverImage = coverImageUrl ?? userDataModel!.coverImage,
      bio,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }

  File? profileImage;
  String? profileImageUrl;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);

      emit(PickProfileImageSuccessState());
      uploadProfileImage();
    } else {
      emit(PickProfileImageErrorState());
    }
  }

  void uploadProfileImage() {
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child('profileImage.jpg')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          profileImageUrl = value;
        }).catchError((error) {
          emit(UploadCoverImageErrorState(error));
        });
      }).catchError((error) {
        emit(UploadCoverImageErrorState(error));
      });
    }
  }

  File? coverImage;
  String? coverImageUrl;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(PickProfileImageSuccessState());
      uploadCoverImage();
    } else {
      emit(PickProfileImageErrorState());
    }
  }

  void uploadCoverImage() {
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child('coverImage.jpg')
          .putFile(coverImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          coverImageUrl = value;
        }).catchError((error) {
          emit(UploadCoverImageErrorState(error));
        });
      }).catchError((error) {
        emit(UploadCoverImageErrorState(error));
      });
    }
  }

  PostDataModel? postDataModel;
  void createPostInDatabase({
    required String dateTime,
    required String text,
    String? postImage,
    String? name,
    String? uId,
    String? image,
  }) {
    PostDataModel postDataModel = PostDataModel(
      name = userDataModel!.name,
      uId = FirebaseAuth.instance.currentUser!.uid,
      image = userDataModel!.profileImage,
      dateTime,
      text,
      postImage = postImageUrl ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postDataModel.toMap())
        .then((value) {
      getPosts();

      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState(error.toString()));
    });
  }

  File? postImage;
  String? postImageUrl;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      uploadPostImage();
      emit(PickPostImageSuccessState());
    } else {
      emit(PickPostImageErrorState());
    }
  }

  void removePostImage() {
    postImageUrl = null;
    emit(RemovePostImageState());
  }

  void uploadPostImage() {
    if (postImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('posts')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(Uri.file(postImage!.path).pathSegments.last)
          .putFile(postImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          postImageUrl = value;
          Future.delayed(const Duration(seconds: 2));
          emit(UploadPostImageSuccessState());
        }).catchError((error) {
          emit(UploadPostImageErrorState(error));
        });
      }).catchError((error) {
        emit(UploadPostImageErrorState(error));
      });
    }
  }

  List<PostDataModel> posts = [];
  //List<String> postId = [];
  //List<int> likes = [];

  void getPosts() {
    posts = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        posts.add(PostDataModel.fromJson(element.data()));
      });
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  bool refresh = false;
  void delayRefresh() {
    getUserData();
    getPosts();
    Future.delayed(const Duration(seconds: 10)).then((value) {
      refresh = true;
      emit(DelayedRefreshSuccessState());
    });
    emit(DelayedRefreshSuccessState());
  }
}

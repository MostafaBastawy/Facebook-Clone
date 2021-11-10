import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/models/comment_model.dart';
import 'package:facebook_clone/models/message_model.dart';
import 'package:facebook_clone/models/post_model.dart';
import 'package:facebook_clone/models/stroy_model.dart';
import 'package:facebook_clone/models/user_model.dart';
import 'package:facebook_clone/screens/feeds_screen.dart';
import 'package:facebook_clone/screens/messenger_screen.dart';
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
    'Messenger',
    'Profile',
  ];
  List<Widget> screens = [
    const FeedsScreen(),
    const MessengerScreen(),
    ProfileScreen(),
  ];
  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    getUsers();

    emit(ChangeBottomNavBarState());
    if (currentIndex == 0) {
      getPosts();
      emit(ChangeBottomNavBarState());
    }
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(UserLoginLoadingState());
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
    emit(UserRegisterLoadingState());
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
      FirebaseAuth.instance.currentUser!.uid,
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
    emit(UserSignOutLoadingState());
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
    String? uid,
  }) {
    UserDataModel userModel = UserDataModel(
      name,
      email = userDataModel!.email,
      phone,
      profileImage = profileImageUrl ?? userDataModel!.profileImage,
      coverImage = coverImageUrl ?? userDataModel!.coverImage,
      bio,
      uid = FirebaseAuth.instance.currentUser!.uid,
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
    if (coverImage != null) {
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

  PostDataModel? model;
  PostDataModel? postDataModel;

  void createPostInDatabase({
    required String dateTime,
    required String text,
    String? postImage,
    String? name,
    String? uId,
    String? image,
    String? createAt,
    String? postUid,
  }) {
    PostDataModel postDataModel = PostDataModel(
      name = userDataModel!.name,
      uId = FirebaseAuth.instance.currentUser!.uid,
      image = userDataModel!.profileImage,
      dateTime,
      text,
      postImage = postImageUrl ?? '',
      createAt,
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
  List<String> postsId = [];
  List<int> commentsNumber = [];
  List likesNumber = [];

  void getPosts() {
    posts = [];
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createAt', descending: true)
        .snapshots()
        .listen((event) {
      posts = [];
      postsId = [];
      commentsNumber = [];
      likesNumber = [];
      emit(GetPostsSuccessState());
      event.docs.forEach((element) {
        posts = [];
        element.reference.collection('likes').get().then((value) {
          emit(GetPostsSuccessState());
          likesNumber.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostDataModel.fromJson(element.data()));
          // element.reference.collection('comments').get().then((value) {
          //   commentsNumber.add(value.docs.length);
          //   emit(GetPostsSuccessState());
          // });
        }).catchError((error) {
          emit(GetPostsErrorState(error.toString()));
        });
        emit(GetPostsSuccessState());
      });
    });
  }

  List<UserDataModel> users = [];

  void getUsers() {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uid'] != FirebaseAuth.instance.currentUser!.uid) {
          users.add(UserDataModel.fromJson(element.data()));
        }
      });
      emit(GetUsersSuccessState());
    }).catchError((error) {
      emit(GetUsersErrorState(error.toString()));
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageDataModel messageDataModel = MessageDataModel(
      FirebaseAuth.instance.currentUser!.uid,
      receiverId,
      dateTime,
      text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageDataModel.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    }).catchError((error) {
      emit(SendMessagesErrorState(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add(messageDataModel.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    }).catchError((error) {
      emit(SendMessagesErrorState(error.toString()));
    });
  }

  List<MessageDataModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageDataModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccessState());
    });
  }

  File? storyImage;
  String? storyImageUrl;

  Future<void> getStoryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      storyImage = File(pickedFile.path);
      uploadStoryImage();
      emit(PickStoryImageSuccessState());
    } else {
      emit(PickStoryImageErrorState());
    }
  }

  void removeStoryImage() {
    postImageUrl = null;
    emit(RemoveStoryImageState());
  }

  void uploadStoryImage() {
    if (storyImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child('storyImage.jpg')
          .putFile(storyImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          storyImageUrl = value;
          emit(UploadPostImageSuccessState());
        }).catchError((error) {
          emit(UploadStoryImageErrorState(error));
        });
      }).catchError((error) {
        emit(UploadStoryImageErrorState(error));
      });
    }
  }

  StoryDataModel? storyDataModel;

  void createStoryInDatabase(
      {required String dateTime,
      String? storyImage,
      String? name,
      String? uId,
      String? image,
      String? createAt}) {
    StoryDataModel storyDataModel = StoryDataModel(
      name = userDataModel!.name,
      uId = FirebaseAuth.instance.currentUser!.uid,
      image = userDataModel!.profileImage,
      dateTime,
      storyImage = storyImageUrl ?? '',
      createAt,
    );
    FirebaseFirestore.instance
        .collection('stories')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(storyDataModel.toMap())
        .then((value) {
      getStories();

      emit(CreateStorySuccessState());
    }).catchError((error) {
      emit(CreateStoryErrorState(error.toString()));
    });
  }

  List<StoryDataModel> stories = [];

  void getStories() {
    stories = [];
    FirebaseFirestore.instance
        .collection('stories')
        .orderBy('createAt', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        stories.add(StoryDataModel.fromJson(element.data()));
      });
      emit(GetStoriesSuccessState());
    }).catchError((error) {
      emit(GetStoriesErrorState(error.toString()));
    });
  }

  void likePost({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }

  CommentDataModel? commentDataModel;
  List<CommentDataModel> comments = [];

  void createCommentInDatabase({
    required String postUid,
    required String dateTime,
    required String createAt,
    required String commentText,
    String? userProfileImageUrl,
    String? userName,
    String? userUid,
  }) {
    CommentDataModel commentDataModel = CommentDataModel(
      postUid,
      dateTime,
      createAt,
      commentText,
      userProfileImageUrl = userDataModel!.profileImage.toString(),
      userName = userDataModel!.name.toString(),
      userUid = FirebaseAuth.instance.currentUser!.uid,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postUid)
        .collection('comments')
        .add(commentDataModel.toMap())
        .then((value) {
      getComments();
    }).catchError((error) {
      emit(CreateCommentInDatabaseErrorState(error));
    });
  }

  void getComments({
    String? postUid,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postUid)
        .collection('comments')
        .orderBy('createAt')
        .snapshots()
        .listen((event) {
      comments = [];
      event.docs.forEach((element) {
        comments.add(CommentDataModel.fromJson(element.data()));
        emit(GetCommentsSuccessState());
      });
    });
  }
}

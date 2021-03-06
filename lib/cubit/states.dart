abstract class AppStates {}

class InitialState extends AppStates {}

class ChangeBottomNavBarState extends AppStates {}

class UserLoginLoadingState extends AppStates {}

class UserLoginSuccessState extends AppStates {}

class UserLoginErrorState extends AppStates {
  final String error;

  UserLoginErrorState(this.error);
}

class UserRegisterLoadingState extends AppStates {}

class UserRegisterSuccessState extends AppStates {}

class UserRegisterErrorState extends AppStates {
  final String error;

  UserRegisterErrorState(this.error);
}

class CreateUserSuccessState extends AppStates {}

class CreateUserErrorState extends AppStates {
  final String error;

  CreateUserErrorState(this.error);
}

class UserSignOutLoadingState extends AppStates {}

class UserSignOutSuccessState extends AppStates {}

class UserSignOutErrorState extends AppStates {
  final String error;

  UserSignOutErrorState(this.error);
}

class CreatePostSuccessState extends AppStates {}

class CreatePostErrorState extends AppStates {
  final String error;

  CreatePostErrorState(this.error);
}

class GetUserDataSuccessState extends AppStates {}

class GetUserDataErrorState extends AppStates {
  final String error;

  GetUserDataErrorState(this.error);
}

class PickProfileImageSuccessState extends AppStates {}

class PickProfileImageErrorState extends AppStates {}

class UploadProfileImageSuccessState extends AppStates {}

class UploadProfileImageErrorState extends AppStates {
  final String error;

  UploadProfileImageErrorState(this.error);
}

class PickCoverImageSuccessState extends AppStates {}

class PickCoverImageErrorState extends AppStates {}

class UploadCoverImageSuccessState extends AppStates {}

class UploadCoverImageErrorState extends AppStates {
  final String error;

  UploadCoverImageErrorState(this.error);
}

class UpdateUserDataSuccessState extends AppStates {}

class UpdateUserDataErrorState extends AppStates {
  final String error;

  UpdateUserDataErrorState(this.error);
}

class PickPostImageSuccessState extends AppStates {}

class PickPostImageErrorState extends AppStates {}

class RemovePostImageState extends AppStates {}

class UploadPostImageSuccessState extends AppStates {}

class UploadPostImageErrorState extends AppStates {
  final String error;

  UploadPostImageErrorState(this.error);
}

class GetPostsSuccessState extends AppStates {}

class GetPostsErrorState extends AppStates {
  final String error;

  GetPostsErrorState(this.error);
}

class DelayedRefreshSuccessState extends AppStates {}

class GetUsersSuccessState extends AppStates {}

class GetUsersErrorState extends AppStates {
  final String error;

  GetUsersErrorState(this.error);
}

class GetMessagesSuccessState extends AppStates {}

class SendMessagesSuccessState extends AppStates {}

class SendMessagesErrorState extends AppStates {
  final String error;

  SendMessagesErrorState(this.error);
}

class CreateStorySuccessState extends AppStates {}

class CreateStoryErrorState extends AppStates {
  final String error;

  CreateStoryErrorState(this.error);
}

class PickStoryImageSuccessState extends AppStates {}

class PickStoryImageErrorState extends AppStates {}

class RemoveStoryImageState extends AppStates {}

class UploadStoryImageSuccessState extends AppStates {}

class UploadStoryImageErrorState extends AppStates {
  final String error;

  UploadStoryImageErrorState(this.error);
}

class GetStoriesSuccessState extends AppStates {}

class GetStoriesErrorState extends AppStates {
  final String error;

  GetStoriesErrorState(this.error);
}

class LikePostSuccessState extends AppStates {}

class LikePostErrorState extends AppStates {
  final String error;

  LikePostErrorState(this.error);
}

class GetLikesSuccessState extends AppStates {}

class GetLikesErrorState extends AppStates {
  final String error;

  GetLikesErrorState(this.error);
}

class CreateCommentInDatabaseSuccessState extends AppStates {}

class CreateCommentInDatabaseErrorState extends AppStates {
  final String error;

  CreateCommentInDatabaseErrorState(this.error);
}

class GetCommentsSuccessState extends AppStates {}

class GetCommentsErrorState extends AppStates {
  final String error;

  GetCommentsErrorState(this.error);
}

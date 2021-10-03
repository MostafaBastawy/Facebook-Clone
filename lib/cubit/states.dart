abstract class AppStates {}

class InitialState extends AppStates {}

class ChangeBottomNavBarState extends AppStates {}

class UserLoginSuccessfulState extends AppStates {}

class UserLoginErrorState extends AppStates {
  final String error;

  UserLoginErrorState(this.error);
}

class UserRegisterSuccessfulState extends AppStates {}

class UserRegisterErrorState extends AppStates {
  final String error;

  UserRegisterErrorState(this.error);
}

class CreateUserSuccessfulState extends AppStates {}

class CreateUserErrorState extends AppStates {
  final String error;

  CreateUserErrorState(this.error);
}

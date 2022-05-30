import 'package:graduation_app/models/user_model.dart';

abstract class AppLoginStates {}

class AppLoginInitialState extends AppLoginStates {}

class AppLoginLoadingState extends AppLoginStates {}

class AppLoginSuccessState extends AppLoginStates {
  UserModel? model;

  AppLoginSuccessState(this.model);
}

class AppLoginErrorState extends AppLoginStates {
  final String error;
  AppLoginErrorState(this.error);
}

class AppLoginPasswordShown extends AppLoginStates {}

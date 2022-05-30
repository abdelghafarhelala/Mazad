import 'package:graduation_app/models/user_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  UserModel? model;

  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterPasswordShown extends RegisterStates {}

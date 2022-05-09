// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/login/loginCubit/loginStates.dart';
import 'package:graduation_app/modules/models/user_model.dart';
import 'package:graduation_app/network/remote/dio_helper.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialState());
  UserModel? loginModel;

  static AppLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(AppLoginLoadingState());
    DioHelper.postData(url: 'loginRout', data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = UserModel.fromJson(value.data);
      print(value.data);
      emit(AppLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppLoginErrorState(error.toString()));
    });
  }

  bool isPass = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibilty() {
    isPass = !isPass;
    isPass
        ? suffix = Icons.visibility_outlined
        : suffix = Icons.visibility_off_outlined;
    emit(AppLoginPasswordShown());
  }
}

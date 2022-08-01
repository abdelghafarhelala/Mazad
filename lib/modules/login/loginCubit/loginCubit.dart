// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/models/add_post_model.dart';
import 'package:graduation_app/models/user_model.dart';
import 'package:graduation_app/modules/login/loginCubit/loginStates.dart';
import 'package:graduation_app/network/endPoint/endPoint.dart';
import 'package:graduation_app/network/local/cache_helper.dart';
import 'package:graduation_app/network/remote/dio_helper.dart';
import 'package:graduation_app/shared/consts/consts.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialState());
  UserModel? loginModel;

  static AppLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(AppLoginLoadingState());
    DioHelper.postDataWithOutToken(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = UserModel.fromJson(value.data);
      print(value.data);
      CacheHelper.saveData(key: "token", value: loginModel!.data!.token!);
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
  // bool isPass = true;
  // IconData suffix = Icons.visibility;
  // void changePasswordVisibility() {
  //   isPass = !isPass;
  //   isPass ? suffix = Icons.visibility : suffix = Icons.visibility_off;
  //   emit(PasswordShownState());
  // }
}

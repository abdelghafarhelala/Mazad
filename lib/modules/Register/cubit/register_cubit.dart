// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/Register/cubit/register_states.dart';
import 'package:graduation_app/modules/models/user_model.dart';
import 'package:graduation_app/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  UserModel? registerModel;
  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String age,
    required String bankAccount,
    required String vodafoneCash,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: 'registerRout', data: {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
      'age': age,
      'bank_account': bankAccount,
      'vodafone_account': vodafoneCash,
    }).then((value) {
      registerModel = UserModel.fromJson(value.data);
      print(value.data);

      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  bool isPass = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibilty() {
    isPass = !isPass;
    isPass
        ? suffix = Icons.visibility_outlined
        : suffix = Icons.visibility_off_outlined;
    emit(RegisterPasswordShown());
  }
}

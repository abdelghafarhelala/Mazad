// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_is_empty, avoid_single_cascade_in_expression_statements, curly_braces_in_flow_control_structures, duplicate_ignore, avoid_function_literals_in_foreach_calls, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/models/catigoryModel.dart';
import 'package:graduation_app/models/productDataModel.dart';
import 'package:graduation_app/models/productModel.dart';
import 'package:graduation_app/models/profileModel.dart';
import 'package:graduation_app/models/user_model.dart';
import 'package:graduation_app/modules/bids/bids.dart';
import 'package:graduation_app/modules/favorites/favorites.dart';

import 'package:graduation_app/modules/new_post/new_post.dart';
import 'package:graduation_app/modules/profile/profile.dart';
import 'package:graduation_app/network/endPoint/endPoint.dart';
import 'package:graduation_app/network/remote/dio_helper.dart';
import 'package:graduation_app/shared/consts/consts.dart';
import 'package:image_picker/image_picker.dart';
import '../catagories/catigories.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    CatagoriesScreen(),
    FavoritesScreen(),
    NewPostScreen(),
    BidsScreen(),
    ProfileScreen(),
    // SettingsScreen(),
  ];

  List<String> titles = [
    'Catagories',
    'Favorites',
    'New Post',
    'Bids',
    'Profile',
  ];

  void changeBottomNav(int index) {
    // if (index == 1) {}
    if (index == 4) {
      getUserData();
    }
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  List<BottomNavigationBarItem> buttomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Post'),
    BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'Bids'),
    BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Profile'),
  ];

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      emit(AppPickProfileImageSuccessState());
    } else {
      print('No Image Selected');
      emit(AppPickProfileImageErrorState());
    }
  }

  // File? coverImage;
  // Future<void> getCoverImage() async {
  //   final pickerFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickerFile != null) {
  //     coverImage = File(pickerFile.path);
  //     emit(AppPickCoverImageSuccessState());
  //   } else {
  //     print('No Image Selected');
  //     emit(AppPickCoverImageErrorState());
  //   }
  // }

  // String profileImageUrl = '';
  // void getData() {
  //   DioHelper.postData(url: 'loginRout', data: {"email": ''});
  // }

  CategoryModel? category;
  void getCategoryData() {
    DioHelper.getDataWithoutToken(url: CATEGORY).then((value) {
      category = CategoryModel.fromJson(value.data);
      print(category?.message?[1].kind);
      print(category?.message?[0].categoryImages);
      emit(AppSuccessCategoryDataState(category!));
    }).catchError((error) {
      emit(AppErrorCategoryDataState(error.toString()));
      print(error.toString());
    });
  }

  ProductModel? product;
  void getAllProducts() {
    emit(AppGetAllProductsLoadingState());
    DioHelper.getData(url: GETPRODUCTS, token: token).then((value) {
      product = ProductModel.fromJson(value.data);
      print(product?.message?[1].id);
      print(product?.message?[0].newPrice);
      emit(AppGetAllProductsSuccessState());
    }).catchError((error) {
      emit(AppGetAllProductsErrorState(error.toString()));
      print(error.toString());
    });
  }

  ProductDataModel? productdata;
  void getProductData({required int id}) {
    emit(AppGetProductDataLoadingState());
    DioHelper.postData(
        url: GETPRODUCTDATA,
        token: token,
        data: {'id': id.toString()}).then((value) {
      productdata = ProductDataModel.fromJson(value.data);
      emit(AppGetProductDataSuccessState());
    }).catchError((error) {
      emit(AppGetProductDataErrorState());
      print(error.toString());
    });
  }

  //GET USER DATA
  ProfileModel? profileModel;
  void getUserData() {
    emit(AppGetUserDataLoadingState());
    DioHelper.postData(url: PROFILE, token: token, data: {}).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print(profileModel?.profileData?.email);
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      emit(AppGetUserDataErrorState());
      print(error.toString());
    });
  }

  UserModel? userModel;
  void UpdateUserData(
      {required String name,
      required String email,
      required int phone,
      required int age,
      required String bankAccount,
      required String vodafoneAccount,
      re}) {
    emit(AppUserUpdateLoadingState());
    DioHelper.postData(
      url: UPDATEPROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'age': age,
        'bank_account': bankAccount,
        'vodafone_account': vodafoneAccount
      },
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel!.data!.name);

      emit(AppUserUpdateSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppUserUpdateErrorState());
    });
  }

//search

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(AppSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '81c14856fba84fda967a563b8f374202',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);

      emit(AppGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetSearchErrorState(error.toString()));
    });
  }
}

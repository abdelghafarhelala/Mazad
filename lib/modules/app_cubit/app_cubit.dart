// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_is_empty, avoid_single_cascade_in_expression_statements, curly_braces_in_flow_control_structures, duplicate_ignore, avoid_function_literals_in_foreach_calls, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/bids/bids.dart';
import 'package:graduation_app/modules/favorites/favorites.dart';
import 'package:graduation_app/modules/models/catigoryModel.dart';
import 'package:graduation_app/modules/models/productModel.dart';
import 'package:graduation_app/modules/new_post/new_post.dart';
import 'package:graduation_app/modules/profile/profile.dart';
import 'package:graduation_app/network/endPoint/endPoint.dart';
import 'package:graduation_app/network/remote/dio_helper.dart';
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
    // if (index == 2) {
    //   emit(AppChangeAddPostBottomNavState());
    // } else {
    currentIndex = index;
    emit(AppChangeBottomNavState());
    // }
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
    DioHelper.getData(url: CATEGORY).then((value) {
      category = CategoryModel.fromJson(value.data);
      print(category?.message?[1].kind);
      print(category?.message?[0].categoryImages);
      emit(AppSuccessCategoryDataState(category!));
    }).catchError((error) {
      emit(AppErrorCategoryDataState(error.toString()));
      print(error.toString());
    });
  }

  GetAllProducts? product;
  void getAllProducts() {
    DioHelper.getData(url: GETPRODUCTS).then((value) {
      product = GetAllProducts.fromJson(value.data);
      print(product?.message?[1].id);
      print(product?.message?[0].newPrice);
      emit(AppGetAllProductsSuccessState());
    }).catchError((error) {
      emit(AppGetAllProductsErrorState(error.toString()));
      print(error.toString());
    });
  }
}

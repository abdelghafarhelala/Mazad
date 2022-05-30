import 'package:graduation_app/models/catigoryModel.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadingState extends AppStates {}

class AppSuccessState extends AppStates {}

class AppErrorState extends AppStates {
  final String error;
  AppErrorState(this.error);
}

class AppChangeBottomNavState extends AppStates {}

class AppChangeAddPostBottomNavState extends AppStates {}

class AppPickProfileImageSuccessState extends AppStates {}

class AppPickProfileImageErrorState extends AppStates {}

class AppPickCoverImageSuccessState extends AppStates {}

class AppPickCoverImageErrorState extends AppStates {}

class AppUpdateCoverImageSuccessState extends AppStates {}

class AppUpdateCoverImageErrorState extends AppStates {}

class AppUpdateProfileImageSuccessState extends AppStates {}

class AppUpdateProfileImageErrorState extends AppStates {}

class AppUpdateProfileLoadingState extends AppStates {}

class AppUpLoadProfileLoadingState extends AppStates {}

class AppUpLoadCoverLoadingState extends AppStates {}

class AppUpdateProfileErrorState extends AppStates {}

// get category
class AppSuccessCategoryDataState extends AppStates {
  final CategoryModel model;
  AppSuccessCategoryDataState(this.model);
}

class AppErrorCategoryDataState extends AppStates {
  final String error;
  AppErrorCategoryDataState(this.error);
}

// get all products
class AppGetAllProductsLoadingState extends AppStates {}

class AppGetAllProductsSuccessState extends AppStates {}

class AppGetAllProductsErrorState extends AppStates {
  final String error;
  AppGetAllProductsErrorState(this.error);
}

// get all products
class AppGetProductDataLoadingState extends AppStates {}

class AppGetProductDataSuccessState extends AppStates {}

class AppGetProductDataErrorState extends AppStates {}

import 'package:graduation_app/models/add_post_model.dart';
import 'package:graduation_app/models/catigoryModel.dart';
import 'package:graduation_app/models/delete_comment.dart';
import 'package:graduation_app/models/delete_product_model.dart';
import 'package:graduation_app/models/favorite_model.dart';
import 'package:graduation_app/models/get_my_products_model.dart';
import 'package:graduation_app/models/get_porduct_category.dart';
import 'package:graduation_app/models/logout_model.dart';
import 'package:graduation_app/models/make_comment_model.dart';
import 'package:graduation_app/models/mazad_model.dart';
import 'package:graduation_app/models/mybids_model.dart';
import 'package:graduation_app/models/product_search.dart';
import 'package:graduation_app/models/profileModel.dart';
import 'package:graduation_app/models/show_comments.dart';
import 'package:graduation_app/models/update_profile_model.dart';
import 'package:graduation_app/models/user_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeThemState extends AppStates {}

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

class AppGetCategoryDataLoadingState extends AppStates {}

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

// get user data
class AppGetUserDataLoadingState extends AppStates {}

class AppGetUserDataSuccessState extends AppStates {}

class AppGetUserDataErrorState extends AppStates {}

//update user data
class AppUserUpdateLoadingState extends AppStates {}

class AppUserUpdateErrorState extends AppStates {}

class AppUserUpdateSuccessState extends AppStates {
  late final updateProfileModel loginModel;
  AppUserUpdateSuccessState(this.loginModel);
}

//update user data
class AppMakeFavoriteLoadingState extends AppStates {}

class AppMakeFavoriteErrorState extends AppStates {}

class AppMakeFavoriteSuccessState extends AppStates {
  final FavoriteModel? model;
  AppMakeFavoriteSuccessState(this.model);
}

class AppChangeColorState extends AppStates {}

//make mazad states
class AppMakeMazadLoadingState extends AppStates {}

class AppMakeMazadErrorState extends AppStates {}

class AppMakeMazadSuccessState extends AppStates {
  late final MazadModel? Model;
  AppMakeMazadSuccessState(this.Model);
}

//get my products states
class AppGetMyProductsLoadingState extends AppStates {}

class AppGetMyProductsErrorState extends AppStates {}

class AppGetMyProductsSuccessState extends AppStates {
  late final GetMyProductsModel? Model;
  AppGetMyProductsSuccessState(this.Model);
}

//get my bids states
class AppGetMyBidsLoadingState extends AppStates {}

class AppGetMyBidsErrorState extends AppStates {}

class AppGetMyBidsSuccessState extends AppStates {
  late final MyBidsModel? Model;
  AppGetMyBidsSuccessState(this.Model);
}

//get product in category states
class AppGetProductInCategoryLoadingState extends AppStates {}

class AppGetProductInCategoryErrorState extends AppStates {}

class AppGetProductInCategorySuccessState extends AppStates {
  late final GetProductsInCategoryModel? Model;
  AppGetProductInCategorySuccessState(this.Model);
}

//make comment states
class AppMakeCommentLoadingState extends AppStates {}

class AppMakeCommentErrorState extends AppStates {}

class AppMakeCommentSuccessState extends AppStates {
  late final MakeCommentModel? model;
  AppMakeCommentSuccessState(this.model);
}

//get all comments
class AppGetAllCommentsLoadingState extends AppStates {}

class AppGetAllCommentsErrorState extends AppStates {}

class AppGetAllCommentsSuccessState extends AppStates {
  late final ShowComments? model;
  AppGetAllCommentsSuccessState(this.model);
}

//delete all comments
class AppDeleteCommentsLoadingState extends AppStates {}

class AppDeleteCommentsErrorState extends AppStates {}

class AppDeleteCommentsSuccessState extends AppStates {
  late final DeleteComment? model;
  AppDeleteCommentsSuccessState(this.model);
}

//delete all comments
class AppDeleteProductsLoadingState extends AppStates {}

class AppDeleteProductsErrorState extends AppStates {}

class AppDeleteProductsSuccessState extends AppStates {
  late final DeleteProductModel? model;
  AppDeleteProductsSuccessState(this.model);
}

//get all comments
class AppLogoutLoadingState extends AppStates {}

class AppLogoutErrorState extends AppStates {}

class AppLogoutSuccessState extends AppStates {
  AppLogoutSuccessState();
}

//product search states
class AppGetSearchLoadingState extends AppStates {}

class AppGetSearchErrorState extends AppStates {}

class AppGetSearchSuccessState extends AppStates {
  late final ProductSearchModel? Model;
  AppGetSearchSuccessState(this.Model);
}

////
class AppPickImageSuccessState extends AppStates {}

class AppPickImageErrorState extends AppStates {}

//pic image states
class AppRemovePickImageState extends AppStates {}

class AppPostNoteSuccessState extends AppStates {
  final AddPostModel? model;

  AppPostNoteSuccessState(this.model);
}

class AppPostNoteErrorState extends AppStates {}

class AppPostNoteLoadingState extends AppStates {}

//// count number of images
class AppCountImageState extends AppStates {}

class AppClearSearchState extends AppStates {}

class AppchangeListValState extends AppStates {}

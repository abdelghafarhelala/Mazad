// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_is_empty, avoid_single_cascade_in_expression_statements, curly_braces_in_flow_control_structures, duplicate_ignore, avoid_function_literals_in_foreach_calls, prefer_const_constructors

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/models/add_post_model.dart';
import 'package:graduation_app/models/category_search_model.dart';
import 'package:graduation_app/models/catigoryModel.dart';
import 'package:graduation_app/models/delete_comment.dart';
import 'package:graduation_app/models/delete_product_model.dart';
import 'package:graduation_app/models/favorite_model.dart';
import 'package:graduation_app/models/get_fav_model.dart';
import 'package:graduation_app/models/get_my_products_model.dart';
import 'package:graduation_app/models/get_porduct_category.dart';
import 'package:graduation_app/models/logout_model.dart';
import 'package:graduation_app/models/make_comment_model.dart';
import 'package:graduation_app/models/mazad_model.dart';
import 'package:graduation_app/models/mybids_model.dart';
import 'package:graduation_app/models/productDataModel.dart';
import 'package:graduation_app/models/productModel.dart';
import 'package:graduation_app/models/product_search.dart';
import 'package:graduation_app/models/profileModel.dart';
import 'package:graduation_app/models/show_comments.dart';
import 'package:graduation_app/models/update_product_model.dart';
import 'package:graduation_app/models/update_profile_model.dart';
import 'package:graduation_app/models/user_model.dart';
import 'package:graduation_app/models/user_search_model.dart';
import 'package:graduation_app/modules/bids/bids.dart';
import 'package:graduation_app/modules/favorites/favorites.dart';
import 'package:graduation_app/modules/login/login.dart';

import 'package:graduation_app/modules/new_post/new_post.dart';
import 'package:graduation_app/modules/product_data/product_data.dart';
import 'package:graduation_app/modules/profile/profile.dart';
import 'package:graduation_app/network/endPoint/endPoint.dart';
import 'package:graduation_app/network/local/cache_helper.dart';
import 'package:graduation_app/network/remote/dio_helper.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:graduation_app/shared/consts/consts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

  var isDark = true;
  void changeAppTheme({bool? fromCache}) {
    if (fromCache != null) {
      isDark = fromCache;
      emit(AppChangeThemState());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemState());
      });
    }
  }

  CategoryModel? category;
  List<Message> cat = [];
  void getCategoryData() {
    emit(AppGetCategoryDataLoadingState());
    DioHelper.getDataWithoutToken(url: CATEGORY).then((value) {
      category = CategoryModel.fromJson(value.data);
      print(category?.message?[1].kind);
      print(category?.message?[0].categoryImages);
      cat = category!.message!;
      emit(AppSuccessCategoryDataState(category!));
    }).catchError((error) {
      emit(AppErrorCategoryDataState(error.toString()));
      print(error.toString());
    });
  }

  Map<int, bool> favorites = {};
  ProductModel? product;
  void getAllProducts() {
    emit(AppGetAllProductsLoadingState());
    DioHelper.getData(url: GETPRODUCTS, token: token).then((value) {
      product = ProductModel.fromJson(value.data);
      product?.message?.forEach((element) {
        favorites.addAll({element.id!: false});
      });
      print(product?.message?[1].id);
      print(product?.message?[0].newPrice);
      emit(AppGetAllProductsSuccessState());
    }).catchError((error) {
      emit(AppGetAllProductsErrorState(error.toString()));
      print(error.toString());
    });
  }

  GetMyProductsModel? myProducts;
  void getMyProducts() {
    emit(AppGetMyProductsLoadingState());
    DioHelper.getData(url: GETMYPRODUCTS, token: token).then((value) {
      // print(value.data);
      myProducts = GetMyProductsModel.fromJson(value.data);
      emit(AppGetMyProductsSuccessState(myProducts));
    }).catchError((error) {
      emit(AppGetMyProductsErrorState());
      print(error.toString());
    });
  }

  ProductDataModel? productdata;
  void getProductData({required int id}) {
    emit(AppGetProductDataLoadingState());
    DioHelper.postData(url: GETPRODUCTDATA, token: token, data: {'id': id})
        .then((value) {
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
      print(profileModel?.message?.email);
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      emit(AppGetUserDataErrorState());
      print(error.toString());
    });
  }
//////////////////////////////////////////////
////////////////////////////////////////
/////////////////////

//pic image
  File? postImage;
  Future<void> picProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      emit(AppPickImageSuccessState());
    } else {
      print('No Image Selected');
      emit(AppPickImageErrorState());
    }
  }

  // void removeImage() {
  //   postImage = null;
  //   emit(AppRemovePickImageState());
  // }

  //post note
  updateProfileModel? userModel;
  void postUpdate(
      {required String name,
      required String email,
      required int phone,
      required int age,
      required String bankAccount,
      required String vodafoneAccount,
      re}) async {
    String? fileName = postImage?.path.split('/').last;
    FormData formData = FormData.fromMap({
      "profile_picture": await MultipartFile.fromFile(
        postImage?.path ?? '',
        filename: fileName,
        contentType: new MediaType("image", "jpeg"), //important
      ),
      'name': name,
      'email': email,
      'phone': phone,
      'age': age,
      'bank_account': bankAccount,
      'vodafone_account': vodafoneAccount
    });
    emit(AppUserUpdateLoadingState());
    Dio dio = new Dio()
      ..options.baseUrl = 'https://mazad.webautobazaar.com/api/';
    dio
        .post(UPDATEPROFILE,
            data: formData,
            options: Options(headers: {
              'Authorization': 'Bearer ' + token!,
            }))
        .then((response) {
      userModel = updateProfileModel.fromJson(response.data);
      getUserData();

      emit(AppUserUpdateSuccessState(userModel!));
      print(response);
    }).catchError((error) {
      print(error.toString());
      emit(AppUserUpdateErrorState());
    });
  }

  FavoriteModel? favoriteModel;
  void makeFavorite({
    required int productId,
  }) {
    favorites[productId] = !favorites[productId]!;
    emit(AppMakeFavoriteLoadingState());
    DioHelper.postData(
      url: FAVORITE,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      print(favoriteModel?.msg);

      emit(AppMakeFavoriteSuccessState(favoriteModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppMakeFavoriteErrorState());
    });
  }

  GetFavoriteModel? getFavoriteModel;
  List<Fav> fav = [];
  List<Fav> toRemoveFav = [];
  void getFavorites() {
    emit(AppMakeFavoriteLoadingState());
    DioHelper.postData(
      url: GETFAV,
      token: token,
      data: {},
    ).then((value) {
      getFavoriteModel = GetFavoriteModel.fromJson(value.data);
      fav = getFavoriteModel!.data!;
      getFavoriteModel?.data?.forEach((element) {
        if (element.product != null) {
          print('fav ffffffffffffffffffffffffffff');
          favorites[element.product!.id!] = true;
          print(favorites[element.product!.id!]);
        } else {
          toRemoveFav.add(element);
        }
      });
      emit(AppMakeFavoriteSuccessState(favoriteModel));
      fav.removeWhere((e) => toRemoveFav.contains(e));
      emit(AppMakeFavoriteSuccessState(favoriteModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppMakeFavoriteErrorState());
    });
  }

  void changeValue() {
    isMazad = true;

    emit(AppChangeColorState());
  }

  //applicant in mazad
  MazadModel? mazadModel;
  void makeMazad({
    required int value,
    required int productId,
  }) {
    emit(AppMakeMazadLoadingState());
    DioHelper.postData(
      url: MAKEMAZAD,
      token: token,
      data: {
        'value': value,
        'product_id': productId.toString(),
      },
    ).then((value) {
      mazadModel = MazadModel.fromJson(value.data);
      emit(AppMakeMazadSuccessState(mazadModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppMakeMazadErrorState());
    });
  }

  //  MazadModel? mazadModel;
  List<BidsData> bids = [];
  MyBidsModel? myBidsModel;
  var toRemove = [];

  void getMyBids() {
    emit(AppGetMyBidsLoadingState());
    DioHelper.postData(
      url: GETMYBIDS,
      token: token,
      data: {},
    ).then((value) {
      myBidsModel = MyBidsModel.fromJson(value.data);
      bids = myBidsModel!.data!;

      myBidsModel!.data!.forEach((element) {
        if (element.productbids == null) {
          toRemove.add(element);
        }
      });
      print('----------------------------------------');
      emit(AppGetMyBidsSuccessState(myBidsModel));
      bids.removeWhere((e) => toRemove.contains(e));
      print(bids.length);
      emit(AppGetMyBidsSuccessState(myBidsModel));
    }).catchError((error) {
      print(error.toString());

      emit(AppGetMyBidsErrorState());
    });
  }

  int index = 0;
  void countImages() {
    index++;
    if (index == 7) {
      emit(AppCountImageState());
    }
    emit(AppCountImageState());
  }

  File? postImage1;
  // File? postImage1;
  File? postImage2;
  File? postImage3;
  File? postImage4;
  File? postImage5;
  File? postImage6;

  // var picker = ImagePicker();
  List<XFile>? imageFileList = [];
  Future<void> getImageFromGalley() async {
    final List<XFile>? images = await picker.pickMultiImage();

    if (images!.isNotEmpty) {
      // PostImage != (File(pickerFile.path));
      imageFileList!.addAll(images);
      emit(AppPickImageSuccessState());
    } else {
      print('No Image Selected');
      emit(AppPickImageErrorState());
    }
  }

  Future<void> getImageFromCamera(File PostImage) async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      PostImage = (File(pickerFile.path));
      emit(AppPickImageSuccessState());
    } else {
      print('No Image Selected');
      emit(AppPickImageErrorState());
    }
  }

  void removeImage(file) {
    imageFileList!.remove(file);
    emit(AppRemovePickImageState());
  }

  AddPostModel? postModel;
  void postNoteData({
    required String ProductName,
    required String description,
    required int numOfBids,
    required int deposite,
    required int price,
    String? startDate,
    required String endDate,
    required int categoryId,
    required String location,
    int? userId,
  }) async {
    emit(AppPostNoteLoadingState());
    String? fileName = imageFileList![0].path.split('/').last;
    FormData formData = FormData.fromMap({
      "product_images[0][image]": await MultipartFile.fromFile(
        imageFileList![0].path,
        filename: fileName,
        contentType: new MediaType("image", "jpeg"), //important
      ),
      //   });
      // },
      'p_name': ProductName,
      'description': description,
      'num_bids': numOfBids,
      'deposite': deposite,
      'old_price': price,
      'new_price': price,
      'start_date': DateFormat.yMMMd().format(DateTime.now()).toString(),
      'end_date': endDate,
      'location': location,
      'user_id': profileModel!.message!.id,
      'cat_id': categoryId,
    });

    Dio dio = new Dio()
      ..options.baseUrl = "https://mazad.webautobazaar.com/api/";
    dio
        .post(STOREPRODUCT,
            data: formData,
            options: Options(headers: {
              'Authorization': 'Bearer' + token!,
            }))
        .then((response) {
      postModel = AddPostModel.fromJson(response.data);
      emit(AppPostNoteSuccessState(postModel));
      print(response);
    }).catchError((error) {
      print(error.toString());
      emit(AppPostNoteErrorState());
    });
  }

  List<String>? fileName = [];
  void fun() {
    imageFileList!.forEach((element) {
      fileName!.add(element.path.split('/').last);
    });
  }

  void postNoteDataWithoutImage({
    required String ProductName,
    required String description,
    required String numOfBids,
    required String deposite,
    required int price,
    String? startDate,
    required DateTime endDate,
    required String categoryId,
    required String location,
    String? userId,
  }) async {
    // String? fileName = imageFileList![0].path.split('/').last;
    fun();
    FormData formData = FormData.fromMap({
      if (imageFileList!.length > 0)
        "product_images[0][image]": await MultipartFile.fromFile(
          imageFileList![0].path,
          filename: fileName![0],
          contentType: new MediaType("image", "jpeg"), //important
        ),
      if (imageFileList!.length > 1)
        "product_images[1][image]": await MultipartFile.fromFile(
          imageFileList![1].path,
          filename: fileName![1],
          contentType: new MediaType("image", "jpeg"), //important
        ),
      if (imageFileList!.length > 2)
        "product_images[2][image]": await MultipartFile.fromFile(
          imageFileList![2].path,
          filename: fileName![2],
          contentType: new MediaType("image", "jpeg"), //important
        ),
      if (imageFileList!.length > 3)
        "product_images[3][image]": await MultipartFile.fromFile(
          imageFileList![3].path,
          filename: fileName![3],
          contentType: new MediaType("image", "jpeg"), //important
        ),
      if (imageFileList!.length > 4)
        "product_images[4][image]": await MultipartFile.fromFile(
          imageFileList![4].path,
          filename: fileName![4],
          contentType: new MediaType("image", "jpeg"), //important
        ),
      if (imageFileList!.length > 5)
        "product_images[5][image]": await MultipartFile.fromFile(
          imageFileList![5].path,
          filename: fileName![5],
          contentType: new MediaType("image", "jpeg"), //important
        ),
      'p_name': ProductName,
      'description': description,
      'num_bids': 0,
      'deposite': deposite,
      'old_price': price,
      'new_price': price,
      'start_date': DateTime.now(),
      'end_date': endDate,
      'location': location,
      'user_id': profileModel!.message!.id!,
      'cat_id': int.parse(categoryId),
    });
    emit(AppPostNoteLoadingState());
    Dio dio = new Dio()
      ..options.baseUrl = "https://mazad.webautobazaar.com/api/";
    dio
        .post(STOREPRODUCT,
            data: formData,
            options: Options(headers: {
              'Authorization': 'Bearer ' + token!,
            }))
        .then((response) {
      print('object object object ${response.data}');

      postModel = AddPostModel.fromJson(response.data);
      emit(AppPostNoteSuccessState(postModel));
      print(response);
    }).catchError((error) {
      print(error.toString());
      emit(AppPostNoteErrorState());
    });
  }

  // void fun() {
  //   imageFileList!.forEach((element) {});
  // }
  List<Productcategory> productCat = [];
  GetProductsInCategoryModel? getProductsInCategoryModel;
  void getProductInCategory({required int categoryId}) {
    emit(AppGetProductInCategoryLoadingState());
    DioHelper.postData(
      url: PRODUCTCATEGORY,
      token: token,
      data: {'id': categoryId},
    ).then((value) {
      print(value.data);

      getProductsInCategoryModel =
          GetProductsInCategoryModel.fromJson(value.data);
      productCat = getProductsInCategoryModel!.data!.productcategory!;
      emit(AppGetProductInCategorySuccessState(getProductsInCategoryModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppGetProductInCategoryErrorState());
    });
  }

  List<SearchProduct> search = [];
  List<CategorySearch> searchCat = [];
  ProductSearchModel? productSearchModel;
  UserSearchModel? userSearchModel;
  CategorySearchModel? categorySearchModel;
  void getSearch({required String text, required String kind}) {
    emit(AppGetSearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        if (kind == 'product')
          'p_name': text
        else if (kind == 'user')
          'name': text
        else if (kind == 'category')
          'kind': text
      },
    ).then((value) {
      if (kind == 'product') {
        productSearchModel = ProductSearchModel.fromJson(value.data);
        search = productSearchModel!.data!;
      } else if (kind == 'user') {
        userSearchModel = UserSearchModel.fromJson(value.data);
      } else if (kind == 'category') {
        categorySearchModel = CategorySearchModel.fromJson(value.data);
        searchCat = categorySearchModel!.data!;
      }

      emit(AppGetSearchSuccessState(productSearchModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppGetSearchErrorState());
    });
  }

  void clearList() {
    search.clear();
    searchCat.clear();
    emit(AppClearSearchState());
  }

  //post comment

  MakeCommentModel? makeCommentModel;
  void MakeComment(
      {int? userId, required String text, required int productId}) {
    emit(AppMakeCommentLoadingState());
    DioHelper.postData(
      url: MAKECOMMENT,
      token: token,
      data: {
        'user_id': profileModel!.message!.id.toString(),
        'product_id': productId.toString(),
        'comment': text,
      },
    ).then((value) {
      makeCommentModel = MakeCommentModel.fromJson(value.data);
      emit(AppMakeCommentSuccessState(makeCommentModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppMakeCommentErrorState());
    });
  }

  //show comments
  List<CommentShow> comments = [];
  ShowComments? showComments;
  void getAllComments({required int productId}) {
    emit(AppGetAllCommentsLoadingState());
    DioHelper.postData(
      url: SHOWCOMMENTS,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      showComments = ShowComments.fromJson(value.data);
      comments = showComments!.data!;
      // print(showComments!.errNum);
      emit(AppGetAllCommentsSuccessState(showComments));
    }).catchError((error) {
      print(error.toString());
      emit(AppGetAllCommentsErrorState());
    });
  }

  //delete comments

  DeleteComment? deleteCommentModel;
  void deleteComment({required int commentId, required int productId}) {
    emit(AppDeleteCommentsLoadingState());
    DioHelper.postData(
      url: DELETECOMMENT,
      token: token,
      data: {
        'id': commentId,
      },
    ).then((value) {
      deleteCommentModel = DeleteComment.fromJson(value.data);
      // print(showComments!.errNum);
      getAllComments(productId: productId);
      emit(AppDeleteCommentsSuccessState(deleteCommentModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppDeleteCommentsErrorState());
    });
  }

  //delete comments

  // LogoutModel? logoutModel;
  // void userLogout() {
  //   emit(AppLogoutLoadingState());
  //   DioHelper.postData(
  //     url: LOGOUT,
  //     token: token,
  //     data: {},
  //   ).then((value) {
  //     logoutModel = LogoutModel.fromJson(value.data);
  //     // print(showComments!.errNum);
  //     emit(AppLogoutSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(AppLogoutErrorState());
  //   });
  // }

  void logOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        profileModel = null;
        navigateAndFinsh(context, LoginScreen());
        emit(AppLogoutSuccessState());
      }
    });
  }

  var selectedItem;
  var selectedItem2;
  void changeListVal(val) {
    selectedItem = val;
    emit(AppchangeListValState());
  }

  DeleteProductModel? deleteProductModel;
  void deleteProduct({required int productId}) {
    emit(AppDeleteProductsLoadingState());
    DioHelper.postData(
      url: DELETEProduct,
      token: token,
      data: {
        'id': productId,
      },
    ).then((value) {
      deleteProductModel = DeleteProductModel.fromJson(value.data);
      // print(showProducts!.errNum);
      getMyProducts();
      emit(AppDeleteProductsSuccessState(deleteProductModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppDeleteProductsErrorState());
    });
  }
}

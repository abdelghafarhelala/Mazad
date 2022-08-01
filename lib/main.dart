// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/home-layout/home-layout.dart';
import 'package:graduation_app/modules/login/login.dart';
import 'package:graduation_app/modules/on_boarding/onBoardingScreen.dart';
import 'package:graduation_app/network/local/cache_helper.dart';
import 'package:graduation_app/network/remote/dio_helper.dart';
import 'package:graduation_app/shared/blocObserver/blocObserver.dart';
import 'package:graduation_app/shared/consts/consts.dart';
import 'package:graduation_app/shared/style/themes.dart';

//firebase background messages

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  await DioHelper.init();
  bool isDark = false;
  token = CacheHelper.getData(key: 'token');
  bool? onboarding = CacheHelper.getData(key: 'onBoarding');
  if (CacheHelper.getData(key: 'isDark') != null) {
    isDark = CacheHelper.getData(key: 'isDark');
  } else {
    isDark = isDark;
  }

  Widget? widget;
  if (onboarding != null) {
    if (token != null) {
      widget = HomeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget!,
        // ProductsScreen()
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;
  // ignore: avoid_types_as_parameter_names
  MyApp({required this.startWidget, required this.isDark});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..changeAppTheme(fromCache: isDark)
        ..getMyProducts()
        ..getCategoryData()
        ..getFavorites()
        ..getAllProducts()
        ..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightThem,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            // home: CommentsScreen()
            home: startWidget,
          );
        },
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/home-layout/home-layout.dart';
import 'package:graduation_app/modules/on_boarding/onBoardingScreen.dart';
import 'package:graduation_app/network/local/cache_helper.dart';
import 'package:graduation_app/network/remote/dio_helper.dart';
import 'package:graduation_app/shared/blocObserver/blocObserver.dart';
import 'package:graduation_app/shared/style/themes.dart';

//firebase background messages

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await CacheHelper.init();
  await DioHelper.init();

  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(
        startWidget: HomeLayout(),
        // ProductsScreen()
      ));
    },
    blocObserver: MyBlocObserver(),
  );

  // var token = await FirebaseMessaging.instance.getToken();
  // print('the token is ' + token!);

  // //firebase foreground messages
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  //   showToast(text: 'Hello From On Message', state: ToastStates.success);
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print(event.data.toString());
  //   showToast(
  //       text: 'Hello From On Message opened app', state: ToastStates.success);
  // });
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  // ignore: avoid_types_as_parameter_names
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getCategoryData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightThem,
            themeMode: ThemeMode.light,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}

// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/menue/menue.dart';
import 'package:graduation_app/modules/notification/notification.dart';
import 'package:graduation_app/modules/search/search_screen.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:graduation_app/shared/consts/consts.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

var fbm = FirebaseMessaging.instance;

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    // sendNotify('abdo', 'hello from abdo', '1', 'abdo', '1500');
    // getMessage();
    fbm.getToken().then((value) {
      print('====================== token ===============================');
      print(value);
      print('=======================================================');
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: state is! AppGetCategoryDataLoadingState,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => Scaffold(
            drawer: MenuScreen(),
            appBar: AppBar(
              title:
                  // color: Colors.white,
                  Text(AppCubit.get(context).titles[cubit.currentIndex]),
              actions: [
                if (cubit.currentIndex == 0)
                  IconButton(
                      onPressed: () {
                        if (cubit.currentIndex > 0) {
                          // navigateTo(context, SearchScreen(kind: 'product'));
                        } else {
                          navigateTo(context, SearchScreen(kind: 'category'));
                          print(cubit.currentIndex);
                        }
                      },
                      icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      navigateTo(context, NotificationScreen());
                    },
                    icon: Icon(Icons.notifications)),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.buttomItems,
              onTap: (index) {
                cubit.changeBottomNav(index);
                if (index == 0) {
                  AppCubit.get(context).getCategoryData();
                } else if (index == 1) {
                  print(token);
                  AppCubit.get(context).getFavorites();
                } else if (index == 3) {
                  AppCubit.get(context).getMyBids();
                }
              },
              currentIndex: cubit.currentIndex,
            ),
          ),
        );
      },
    );
  }
}

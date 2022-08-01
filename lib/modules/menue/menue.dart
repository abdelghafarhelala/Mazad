// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/bids/bids.dart';
import 'package:graduation_app/modules/favorites/favorites.dart';
import 'package:graduation_app/modules/home-layout/home-layout.dart';
import 'package:graduation_app/modules/login/login.dart';
import 'package:graduation_app/modules/my_products/my_products_screen.dart';
import 'package:graduation_app/modules/new_post/new_post.dart';
import 'package:graduation_app/modules/profile/profile.dart';
import 'package:graduation_app/network/local/cache_helper.dart';
import 'package:graduation_app/shared/consts/consts.dart';
import 'package:graduation_app/shared/style/color.dart';

import '../../shared/components/components.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is AppLogoutSuccessState) {
        showToast(text: 'Logout Successfully', state: ToastStates.success);
      }
    }, builder: (context, state) {
      return Drawer(
        child: ConditionalBuilder(
          condition: state is! AppGetUserDataLoadingState,
          fallback: (context) => CircularProgressIndicator(),
          builder: (context) => ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  AppCubit.get(context).profileModel?.message?.name ?? "",
                  style: TextStyle(
                      color: AppCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black),
                ),
                accountEmail: Text(
                  AppCubit.get(context).profileModel?.message?.email ?? "",
                  style: TextStyle(
                      color: AppCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black),
                ),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      AppCubit.get(context)
                              .profileModel
                              ?.message
                              ?.profilePicture ??
                          'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1648830402~exp=1648831002~hmac=23bb5c012cffe2b975c10240fb7aa2f906cd61fc0e106b73ae52d85af1159554',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: AppCubit.get(context).isDark
                        ? darkColor
                        : Colors.white),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(
                  AppCubit.get(context).profileModel?.message?.phone ?? "",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text(
                  'favorites',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  AppCubit.get(context).getFavorites();
                  AppCubit.get(context).currentIndex = 1;
                  navigateTo(context, HomeLayout());
                },
              ),
              ListTile(
                leading: Icon(Icons.gavel),
                title: Text(
                  'Bids',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  AppCubit.get(context).getMyBids();
                  AppCubit.get(context).currentIndex = 3;
                  navigateTo(context, HomeLayout());
                },
              ),
              ListTile(
                leading: Icon(Icons.gavel),
                title: Text(
                  'My Products',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  AppCubit.get(context).getMyProducts();

                  navigateTo(context, MyProductsScreen());
                },
              ),
              ListTile(
                leading: Icon(Icons.post_add_outlined),
                title: Text(
                  'New Post',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  //  AppCubit.get(context).getMyBids();
                  AppCubit.get(context).currentIndex = 2;
                  navigateTo(context, HomeLayout());
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  //  AppCubit.get(context).getMyBids();
                  AppCubit.get(context).currentIndex = 4;
                  navigateTo(context, HomeLayout());
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.brightness_medium,
                ),
                title: FlutterSwitch(
                  inactiveColor: Colors.white,
                  inactiveToggleColor: Colors.grey,
                  activeColor: defaultColor,
                  activeText: 'Dark',
                  height: 25,
                  width: 60,
                  inactiveSwitchBorder: Border.all(color: Colors.black),
                  activeTextColor: Colors.white,
                  value: AppCubit.get(context).isDark,
                  onToggle: (value) {
                    AppCubit.get(context).changeAppTheme();
                  },
                ),
                onTap: () {
                  AppCubit.get(context).logOut(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  AppCubit.get(context).logOut(context);
                },
              ),
            ],
          ),
        ),
        // child: Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: Column(
        //     children: [
        //       Row(
        //         children: [
        //           Column(
        //             children: [
        //               CircleAvatar(
        //                 radius: 55,
        //                 backgroundImage: NetworkImage(
        //                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcGJegujCz3neLg3btfiVRfmV4dg52BBd38g&usqp=CAU',
        //                 ),
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             width: 15,
        //           ),
        //           Column(
        //             children: [
        //               Row(
        //                 children: [
        //                   Text(
        //                     'User Name ',
        //                     style: TextStyle(
        //                         fontWeight: FontWeight.w400,
        //                         color: Colors.black87,
        //                         fontSize: 25),
        //                   ),
        //                 ],
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     'all your shortcuts ',
        //                     style: TextStyle(fontSize: 15, color: Colors.grey),
        //                   ),
        //                 ],
        //               )
        //             ],
        //           )
        //         ],
        //       ),
        //       SizedBox(
        //         height: 24.0,
        //       ),
        //       Row(
        //         children: [
        //           SizedBox(
        //             width: 13.0,
        //           ),
        //           Column(
        //             children: [
        //               Icon(
        //                 Icons.phone,
        //                 color: Colors.grey,
        //                 size: 18,
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             width: 15.0,
        //           ),
        //           Column(
        //             children: [
        //               InkWell(
        //                 onTap: () {},
        //                 child: Text(
        //                   '(581)-307-6902',
        //                   style: TextStyle(color: Colors.grey, fontSize: 13),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //       SizedBox(
        //         height: 16.0,
        //       ),
        //       Row(
        //         children: [
        //           SizedBox(
        //             width: 13.0,
        //           ),
        //           Column(
        //             children: [
        //               Icon(
        //                 Icons.email_outlined,
        //                 color: Colors.grey,
        //                 size: 18,
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             width: 15.0,
        //           ),
        //           Column(
        //             children: [
        //               InkWell(
        //                 onTap: () {},
        //                 child: Text(
        //                   ' user.name@gmail.com',
        //                   style: TextStyle(color: Colors.grey, fontSize: 13),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //       SizedBox(
        //         height: 24.0,
        //       ),
        //       Container(
        //         height: 1,
        //         color: Colors.grey[200],
        //       ),
        //       SizedBox(
        //         height: 24.0,
        //       ),
        //       Row(
        //         children: [
        //           SizedBox(
        //             width: 13.0,
        //           ),
        //           Column(
        //             children: [
        //               Icon(
        //                 Icons.favorite_border_rounded,
        //                 color: Colors.black38,
        //                 size: 25,
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             width: 15.0,
        //           ),
        //           Column(
        //             children: [
        //               InkWell(
        //                 onTap: () {},
        //                 child: Text(
        //                   'Your Favorites',
        //                   style: TextStyle(color: Colors.black87, fontSize: 18),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //       SizedBox(
        //         height: 24.0,
        //       ),
        //       Row(
        //         children: [
        //           SizedBox(
        //             width: 13.0,
        //           ),
        //           Column(
        //             children: [
        //               Icon(
        //                 Icons.gavel,
        //                 color: Colors.black38,
        //                 size: 25,
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             width: 15.0,
        //           ),
        //           Column(
        //             children: [
        //               InkWell(
        //                 onTap: () {},
        //                 child: Text(
        //                   'Your Bids',
        //                   style: TextStyle(color: Colors.black87, fontSize: 18),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //       SizedBox(
        //         height: 24.0,
        //       ),
        //       Row(
        //         children: [
        //           SizedBox(
        //             width: 13.0,
        //           ),
        //           Column(
        //             children: [
        //               Icon(
        //                 Icons.post_add,
        //                 color: Colors.black38,
        //                 size: 25,
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             width: 15.0,
        //           ),
        //           Column(
        //             children: [
        //               InkWell(
        //                 onTap: () {},
        //                 child: Text(
        //                   'Your Posts',
        //                   style: TextStyle(color: Colors.black87, fontSize: 18),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //       SizedBox(
        //         height: 24.0,
        //       ),
        //       Row(
        //         children: [
        //           SizedBox(
        //             width: 13.0,
        //           ),
        //           Column(
        //             // ignore: prefer_const_literals_to_create_immutables
        //             children: [
        //               Icon(
        //                 Icons.account_balance_wallet_outlined,
        //                 color: Colors.black38,
        //                 size: 25,
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             width: 15.0,
        //           ),
        //           Column(
        //             children: [
        //               InkWell(
        //                 onTap: () {},
        //                 child: Text(
        //                   'Payment',
        //                   style: TextStyle(color: Colors.black87, fontSize: 18),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //       SizedBox(
        //         height: 24.0,
        //       ),
        //       Row(
        //         children: [
        //           SizedBox(
        //             width: 13.0,
        //           ),
        //           Column(
        //             // ignore: prefer_const_literals_to_create_immutables
        //             children: [
        //               Icon(
        //                 Icons.person,
        //                 color: Colors.black38,
        //                 size: 25,
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             width: 15.0,
        //           ),
        //           Column(
        //             children: [
        //               InkWell(
        //                 onTap: () {},
        //                 child: Text(
        //                   'profile',
        //                   style: TextStyle(color: Colors.black87, fontSize: 18),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //       SizedBox(
        //         height: 24.0,
        //       ),
        //       Row(
        //         children: [
        //           SizedBox(
        //             width: 13.0,
        //           ),
        //           Column(
        //             // ignore: prefer_const_literals_to_create_immutables
        //             children: [
        //               Icon(
        //                 Icons.settings,
        //                 color: Colors.black38,
        //                 size: 25,
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             width: 15.0,
        //           ),
        //           Column(
        //             children: [
        //               InkWell(
        //                 onTap: () {},
        //                 child: Text(
        //                   'Settings',
        //                   style: TextStyle(color: Colors.black87, fontSize: 18),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //       SizedBox(
        //         height: 24.0,
        //       ),
        //       Container(
        //         height: 1,
        //         color: Colors.grey[200],
        //       ),
        //       SizedBox(
        //         height: 24.0,
        //       ),
        //       Row(
        //         children: [
        //           SizedBox(
        //             width: 13.0,
        //           ),
        //           Column(
        //             // ignore: prefer_const_literals_to_create_immutables
        //             children: [
        //               Icon(
        //                 Icons.power_settings_new,
        //                 color: Colors.red,
        //                 size: 25,
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             width: 15.0,
        //           ),
        //           Column(
        //             children: [
        //               InkWell(
        //                 onTap: () {},
        //                 child: Text(
        //                   'Log out',
        //                   style: TextStyle(color: Colors.red, fontSize: 18),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      );
    });
  }
}

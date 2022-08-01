// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_app/shared/style/color.dart';

ThemeData lightThem = ThemeData(
  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: lightTextColor),
    titleTextStyle: TextStyle(
        color: lightTextColor, fontSize: 19, fontWeight: FontWeight.w600),
    toolbarTextStyle: TextStyle(
      color: lightTextColor,
    ),
  ),
  primarySwatch: Palette.kToDark,
  primaryColor: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: defaultColor,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 20,
    type: BottomNavigationBarType.fixed,
  ),
  // appBarTheme: AppBarTheme(
  //     backgroundColor: defaultColor,
  //     elevation: 0,
  //     toolbarTextStyle: TextStyle(color: Colors.white),
  //     titleTextStyle: TextStyle(
  //       color: Colors.white,
  //       fontSize: 20,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     iconTheme: IconThemeData(color: Colors.white)),
  backgroundColor: Colors.white70,

  //input theme
  inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Colors.grey,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      fillColor: Colors.grey,
      hoverColor: Colors.grey,
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      labelStyle: TextStyle(color: Colors.grey),
      iconColor: Colors.grey,
      prefixIconColor: Colors.grey,
      hintStyle: TextStyle(color: Colors.grey)),
  //text button theme
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(defaultColor),
  )),
  //text theme

  textTheme: const TextTheme(
    button: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    // subtitle1: TextStyle(
    //   fontSize: 17,
    //   color: Colors.red,
    // ),
    subtitle2: TextStyle(
      fontSize: 17,
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    headline1: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize: 21,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
    headline4: TextStyle(
        fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
    headline5: TextStyle(
        fontSize: 15, fontWeight: FontWeight.w300, color: Colors.black),
    caption: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w300, color: Colors.black),
  ),

  //card theme
  cardColor: Colors.white,
  cardTheme: const CardTheme(
    elevation: 5,
    shadowColor: Colors.grey,
  ),

  toggleableActiveColor: defaultColor,
  unselectedWidgetColor: Colors.grey,
);
ThemeData darkTheme = ThemeData(
  // dialogBackgroundColor: darkColor,
  dialogTheme: DialogTheme(
      backgroundColor: darkColor,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
  appBarTheme: AppBarTheme(
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: darkColor, statusBarIconBrightness: Brightness.light),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    color: darkColor,
    toolbarTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Colors.grey,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      fillColor: Colors.grey,
      hoverColor: Colors.grey,
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      labelStyle: TextStyle(color: Colors.grey),
      iconColor: Colors.grey,
      prefixIconColor: Colors.grey,
      hintStyle: TextStyle(color: Colors.grey)),
  primarySwatch: Palette.kToDark,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.amber,
    textTheme: ButtonTextTheme.primary,
    alignedDropdown: true,
    disabledColor: Colors.grey,
    hoverColor: Colors.grey,
  ),
  scaffoldBackgroundColor: darkColor,
  primaryColor: defaultColor,
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(defaultColor),
  )),
  textTheme: TextTheme(
    button: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    // subtitle1: TextStyle(
    //   fontSize: 17,
    //   color: Colors.red,
    // ),
    subtitle2: TextStyle(
      fontSize: 17,
      color: defaultColor,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    headline1: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline2: TextStyle(
      fontSize: 21,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
    headline4: TextStyle(
        fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
    headline5: TextStyle(
        fontSize: 15, fontWeight: FontWeight.w300, color: Colors.black),
    caption: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white))),
  listTileTheme: const ListTileThemeData(
    textColor: Colors.grey,
  ),
  cardColor: Colors.black87,
  cardTheme: const CardTheme(
    elevation: 5,
    shadowColor: Colors.grey,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(86, 63, 63, 64),
      elevation: 10,
      selectedIconTheme: IconThemeData(
        color: defaultColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey,
      ),
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true),
  toggleableActiveColor: defaultColor,
  unselectedWidgetColor: Colors.grey,
  canvasColor: Colors.grey,
  hintColor: Colors.grey,
  drawerTheme: DrawerThemeData(width: 240),
);

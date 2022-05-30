// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:graduation_app/shared/style/color.dart';

ThemeData lightThem = ThemeData(
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
  appBarTheme: AppBarTheme(
      backgroundColor: defaultColor,
      elevation: 0,
      toolbarTextStyle: TextStyle(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white)),
  backgroundColor: Colors.white70,

  //input theme
  inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Colors.grey,
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      fillColor: Colors.grey,
      hoverColor: Colors.grey,
      border: OutlineInputBorder(),
      enabledBorder: UnderlineInputBorder(
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
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
      headline1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300,
        color: Colors.black87,
      ),
      headline2: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: Colors.black87,
      ),
      caption: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      )),

  //card theme
  cardColor: Colors.white,
  cardTheme: const CardTheme(
    elevation: 5,
    shadowColor: Colors.grey,
  ),

  toggleableActiveColor: defaultColor,
  unselectedWidgetColor: Colors.grey,
);

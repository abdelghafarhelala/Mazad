// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:graduation_app/shared/style/color.dart';

ThemeData lightThem = ThemeData(
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
    backgroundColor: Colors.white70);

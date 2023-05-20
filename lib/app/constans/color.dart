import 'package:flutter/material.dart';

const appPurple = Color(0xFF433AA1);
const appPurpleDark = Color(0xFF1E0771);
const appPurpleLight1 = Color(0xFF9345F2);
const appPurpleLight2 = Color(0xFF89A2D8);
const appWhite = Color(0xFFFAF8FC);
const appOrange = Color(0xFFE6704A);

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: appPurple),
  primaryColor: appPurple,
  appBarTheme: AppBarTheme(
    elevation: 4,
    backgroundColor: appPurple,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: appPurpleDark),
    bodyText2: TextStyle(color: appPurpleDark),
  ),
  listTileTheme: ListTileThemeData(textColor: appPurpleDark),
);

ThemeData themeDark = ThemeData(
  brightness: Brightness.dark,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: appWhite),
  primaryColor: appPurple,
  scaffoldBackgroundColor: appPurpleDark,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: appPurpleDark,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: appWhite),
    bodyText2: TextStyle(color: appWhite),
  ),
  listTileTheme: ListTileThemeData(textColor: appWhite),
);

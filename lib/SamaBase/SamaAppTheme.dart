import 'package:flutter/material.dart';

enum AppTheme {
  AmberLight,
  AmberDark,
}

final appThemeData = {
  AppTheme.AmberLight: ThemeData(
    // scaffoldBackgroundColor: Color(0xEEEEEEEE),
    brightness: Brightness.light,
    primaryColor: Colors.white,
    primarySwatch: Colors.green,
    //primaryColor: Colors.grey,
    fontFamily: 'IranSans',
    
  ),
  AppTheme.AmberDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.amber[700],
    fontFamily: 'IranSans',
  )
};

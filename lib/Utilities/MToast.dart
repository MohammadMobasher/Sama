import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MToast {
  static ToastGravity toastGravity = ToastGravity.BOTTOM;
  static const Toast toastLength = Toast.LENGTH_SHORT;
  static const Color textColor = Colors.white;

  static void Show(String message, ToastGravity gravity, Color backgroundColor,
      double fontSize,
      {Color textConlor: textColor, Toast lenght: toastLength}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: lenght,
        gravity: gravity,
        timeInSecForIos: 1,
        backgroundColor: backgroundColor,
        textColor: textConlor,
        fontSize: fontSize);
  }

  static void Success() {
    Fluttertoast.showToast(
        msg: "عملیات با موفقیت انجام شد",
        toastLength: toastLength,
        gravity: toastGravity,
        timeInSecForIos: 1,
        backgroundColor: Colors.green[400],
        textColor: textColor,
        fontSize: 16.0);
  }

  static void Error() {
    Fluttertoast.showToast(
        msg: "عملیات با خطا انجام شد",
        toastLength: toastLength,
        gravity: toastGravity,
        timeInSecForIos: 1,
        backgroundColor: Colors.red[400],
        textColor: textColor,
        fontSize: 16.0);
  }
}

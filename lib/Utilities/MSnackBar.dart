import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MSnackBar {
  static void Success(BuildContext context) {
    final SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      content: Text("عملیات با موفقیت انجام شد"),
      action: SnackBarAction(label: "باشه", onPressed: () {}),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void SuccessWithText(BuildContext context, String text) {
    final SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      content: Text(text),
      action: SnackBarAction(label: "باشه", onPressed: () {}),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void Error(BuildContext context) {
    final SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      content: Text("عملیات با خطا مواجه شد"),
      action: SnackBarAction(label: "باشه", onPressed: () {}),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void ErrorWithText(BuildContext context, String text) {
    final SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      content: Text(text),
      action: SnackBarAction(label: "باشه", onPressed: () {}),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class MSnackBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final SnackBar snackBar = SnackBar(
//       behavior: SnackBarBehavior.floating,
//       content: Text("عملیات با موفقیت انجام شد"),
//       action: SnackBarAction(label: "باشه", onPressed: () {}),
//     );
//     Scaffold.of(context).showSnackBar(snackBar);
//   }
// }

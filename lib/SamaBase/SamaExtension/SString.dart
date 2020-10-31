// import 'package:flutter/cupertino.dart';
// extension NewExtension on double {
//   int get myMethod {
//     return (1/this*10).toInt();
//   }
// }
import 'package:flutter/cupertino.dart';

extension SString on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

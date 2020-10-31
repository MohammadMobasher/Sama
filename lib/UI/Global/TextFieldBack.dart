import 'package:sama/SamaBase/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldBack extends StatelessWidget {
  final Widget child;
  
  const TextFieldBack({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 6),
      // width: size.width * 0.85,
      decoration: BoxDecoration(
          color: kPrimaryLightColor, borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama/SamaBase/Constants.dart';

class SButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const SButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      width: size.width * 0.90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 10),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 14),
          ),
        ),
      ),
    );
  }
}

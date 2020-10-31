import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MLinearProgressBar extends StatelessWidget {
  final double height;
  final Color backgroundColor;
  final bool isActive;

  const MLinearProgressBar(
      {Key key,
      this.backgroundColor = Colors.white,
      this.height = 2.0,
      this.isActive = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (isActive
        ? SizedBox(
            height: this.height,
            child: new LinearProgressIndicator(
              backgroundColor: this.backgroundColor,
            ),
          )
        : Container(color: Colors.black));
  }
}

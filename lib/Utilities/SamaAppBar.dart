import 'package:sama/SamaBase/Strings.dart';
import 'package:flutter/material.dart';

class SamaAppBar extends StatefulWidget implements PreferredSizeWidget {
  SamaAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<SamaAppBar> {
  Widget appBarTitle = new Text(Strings.AppBarName);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            //bottom: Radius.circular(18),
            ),
      ),
      title: appBarTitle,
      titleSpacing: 0.0,
    );
  }
}

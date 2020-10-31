import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sama/SamaBase/SamaExtension/SColor.dart';

class SDrawerItem extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool selected;
  final Icon leading;
  final Color color;

  const SDrawerItem(
      {Key key, this.text, this.onTap, this.selected, this.leading, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          //color: SColor.getColorFromHex("D7FFFE"),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
              color: (selected
                  ? SColor.getColorFromHex("#F4EDB2")
                  : Colors.transparent)),
          //,
          child: ListTile(
            selected: selected,
            title: Text(text, style: TextStyle(color: color)),
            leading: leading,
          ),
        ),
        onTap: onTap);
  }
}

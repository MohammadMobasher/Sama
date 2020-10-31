import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama/SamaBase/Constants.dart';

class MTabBNB extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final bool isSelected;

  static const Color textNonSelectedColor = Color(0xFFbfbfbf);
  static const Color iconNonSelectedColor = Color(0xFFbfbfbf);

  static const Color textSelectedColor = kPrimaryColor;
  static const Color iconSelectedColor = kPrimaryColor;

  const MTabBNB({Key key, this.title, this.icon, this.onTap, this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icon,
                        color: (isSelected
                            ? iconSelectedColor
                            : iconNonSelectedColor)),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 12,
                          color: (isSelected
                              ? textSelectedColor
                              : textNonSelectedColor)),
                    ),
                  ],
                ),
                // Positioned(
                //   top: -6,
                //   right: 0,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 6,
                //     ),
                //     decoration: BoxDecoration(
                //         shape: BoxShape.circle, color: Colors.red),
                //     alignment: Alignment.center,
                //     child: Text('1',
                //         style: TextStyle(color: Colors.white, fontSize: 10)),
                //   ),
                // )
              ],
            )));
  }
}

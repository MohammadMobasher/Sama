import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sama/Utilities/MTabBNB.dart';
import 'package:sama/Utilities/SamaAppBar.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _homePage();
  }
}

class _homePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: SamaAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add_comment), onPressed: null),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MTabBNB(
                icon: Icons.message,
                title: "دریافتی",
                isSelected: true,
              ),
              MTabBNB(
                icon: Icons.send,
                title: "ارسالی",
                isSelected: false,
              )
            ],
          )),
      // BottomNavigationBar(
      //   backgroundColor: Colors.green,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.access_alarm), title: Text("d")),
      //     BottomNavigationBarItem(icon: Icon(Icons.access_alarm), title: Text("d")),

      //   ]
      //   ),
      body: new Text("data"),
    );
  }
}

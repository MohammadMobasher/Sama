import 'package:cached_network_image/cached_network_image.dart';
import 'package:sama/BloC/Pagination/PaginationBloc.dart';
import 'package:sama/BloC/Login/LoginBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sama/BloC/Login/LoginEvent.dart';
import 'package:sama/BloC/Pagination/PaginationEvent.dart';
import 'package:sama/BloC/Pagination/PaginationState.dart';
import 'package:sama/UI/Global/SDrawerItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama/Utilities/MPref.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SDrawer extends StatefulWidget {
  @override
  _SDrawerState createState() => _SDrawerState();
}

class _SDrawerState extends State<SDrawer> with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  SharedPreferences sharedPrefs;
  Future<void> _getPrefs() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var currentPaginationState = BlocProvider.of<PaginationBloc>(context).state;

    return Drawer(
        child: Column(
      children: <Widget>[
        new Expanded(
            child: ListView(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/interface.jpg'),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                  //decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40)
                                  //borderRadius: BorderRadius.all(Radius.circular(13.0))
                                  // )
                                  ,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: 70,
                                    width: 70,
                                    imageUrl:
                                        //"https://www.talkwalker.com/images/2020/blog-headers/image-analysis.png",
                                        MPref.getString("Image"),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ))
                            ],
                          ),
                        )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Text(
                            MPref.getString("FullName"),
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                )),
            // Align(
            //     alignment: Alignment.bottomRight,
            //     child: Padding(
            //       padding: const EdgeInsets.all(10),
            //       child: Column(
            //         children: <Widget>[
            //           CircleAvatar(
            //             radius: 30.0,
            //             backgroundImage: AssetImage(
            //                 'assets/images/interface.jpg'),
            //           ),
            //           Text(nameFamily),
            //         ],
            //       ),
            //     )),

            // ListTile(
            //   leading: CircleAvatar(
            //     radius: 25.0,
            //     backgroundImage:
            //         ExactAssetImage('assets/images/interface.jpg'),
            //   ),
            //   title: Text(
            //     "محمد مبشر زرقانی",
            //   ),
            // ),
            SDrawerItem(
              onTap: () {
                Navigator.of(context).pop();
                BlocProvider.of<PaginationBloc>(context)
                    .add(PaginationEventProfile());
              },
              text: "پروفایل من",
              leading: new Icon(Icons.account_circle),
              selected: currentPaginationState is PaginationStateProfile
                  ? true
                  : false,
            ),

            SDrawerItem(
              onTap: () {
                Navigator.of(context).pop();
                BlocProvider.of<PaginationBloc>(context)
                    .add(PaginationEventMessage());
              },
              text: "پیام‌ها",
              leading: new Icon(Icons.message),
              selected: currentPaginationState is PaginationStateMessage
                  ? true
                  : false,
            ),

            // SDrawerItem(
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     BlocProvider.of<PaginationBloc>(context)
            //         .add(PaginationEventAboutUs());
            //   },
            //   text: "درباره ما",
            //   leading: new Icon(Icons.info_outline),
            //   selected: currentPaginationState is PaginationStateAboutUs
            //       ? true
            //       : false,
            // ),

            SDrawerItem(
              onTap: () {
                Navigator.of(context).pop();
                BlocProvider.of<LoginBLoc>(context).add(LoginEventLogOut());
              },
              text: "خروج",
              leading: new Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              selected: false,
              color: Colors.red,
            ),
          ],
        )),
        new Container(
          height: 60.0,
          decoration: BoxDecoration(color: Colors.white
              //Color(0xFF009933),
              ),
          child: Center(
            child: Text("نسخه 1.1.1"),
          ),
        ),
      ],
    ));
    // });
    // }
    // );
  }
}

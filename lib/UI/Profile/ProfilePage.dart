import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sama/BloC/Login/LoginBloc.dart';
import 'package:sama/BloC/Login/LoginEvent.dart';
import 'package:sama/BloC/User/UserBloc.dart';
import 'package:sama/BloC/User/UserEvent.dart';
import 'package:sama/BloC/User/UserState.dart';
import 'package:sama/SamaBase/Constants.dart';
import 'package:sama/UI/Global/SButton.dart';

import 'package:sama/UI/Global/SDrawer.dart';
import 'package:sama/UI/Global/TextFieldBack.dart';
import 'package:sama/Utilities/MPref.dart';
import 'package:sama/Utilities/MSnackBar.dart';
import 'package:sama/Utilities/SamaAppBar.dart';

import 'ProfilePageLogic.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ===================================================================
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // ===================================================================

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profilePageLogic = ProfilePageLogic();

    _onPressedChangePassBtn() {
      _currentPasswordController.text = "";
      _newPasswordController.text = "";
      _confirmPasswordController.text = "";
      BlocProvider.of<UserBloc>(context).add(UserEventChangePassword(
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
          confirmNewPassword: _confirmPasswordController.text));
    }

    return BlocBuilder<UserBloc, UserState>(
      builder: (context1, state) {
        return Scaffold(
            appBar: SamaAppBar(),
            drawer: SDrawer(),
            //resizeToAvoidBottomInset: false,
            body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: SizedBox(
                      height: (MediaQuery.of(context).size.height) - 100,
                      child: Column(
                        children: <Widget>[
                          Container(
                            // padding: EdgeInsets.all(20),
                            height: 100,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 120,
                                  padding: EdgeInsets.only(
                                      top: 10, right: 10, bottom: 10, left: 0),
                                  height: 120,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: <Widget>[
                                      Positioned(
                                        child: CircleAvatar(
                                            radius: 40,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    MPref.getString("Image")
                                                    // AssetImage(
                                                    //     'assets/images/interface.jpg'),
                                                    )),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(MPref.getString("FullName")),
                                      Text(MPref.getString("PostTitle"),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.green)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .8,
                            child: Divider(),
                          ),
                          Text(
                            "تغییر رمز عبور",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Text(
                          //   "رمز عبور باید حداقل 6 کاراکتر باشد",
                          //   style: TextStyle(
                          //     fontSize: 12,

                          SizedBox(
                            height: 15,
                          ),

                          TextFieldBack(
                            child: StreamBuilder<String>(
                                stream: profilePageLogic.oldPass,
                                builder: (context, snapshot) => TextFormField(
                                      onChanged: profilePageLogic.oldPassChange,
                                      controller: _currentPasswordController,
                                      obscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.lock_outline),
                                          hintText: "رمز فعلی را وارد کنید",
                                          labelText: "رمز فعلی",
                                          errorText: snapshot.error,
                                          errorStyle: TextStyle(
                                            fontSize: 12,
                                          )),
                                    )),
                          ),
                          TextFieldBack(
                              child: StreamBuilder<String>(
                            stream: profilePageLogic.newPass,
                            builder: (context, snapshot) => TextFormField(
                              controller: _newPasswordController,
                              onChanged: profilePageLogic.newPassChange,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.lock_outline),
                                  hintText: "رمز جدید را وارد کنید",
                                  labelText: "رمز جدید",
                                  errorText: snapshot.error,
                                  errorStyle: TextStyle(
                                    fontSize: 12,
                                  )),
                            ),
                          )),
                          TextFieldBack(
                              child: StreamBuilder<String>(
                            stream: profilePageLogic.confirmNewPass,
                            builder: (context, snapshot) => TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              onChanged: profilePageLogic.confirmNewPassChange,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.lock_outline),
                                  hintText: "رمز جدید را دوباره وارد کنید",
                                  labelText: "تکرار رمز جدید",
                                  errorText: snapshot.error,
                                  errorStyle: TextStyle(
                                    fontSize: 12,
                                  )),
                            ),
                          )),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: StreamBuilder<bool>(
                                  stream: profilePageLogic.submitCheck,
                                  builder: (context, snapshot) => SButton(
                                        text: "  تغییر رمز عبور",
                                        color: snapshot.hasData
                                            ? kPrimaryColor
                                            : Colors.grey,
                                        press: () {
                                          snapshot.hasData
                                              ? _onPressedChangePassBtn()
                                              : null;
                                        },
                                      )),
                            ),
                          )
                        ],
                      )),
                ),
                loadingAndEventHandling(state, context)
              ],
            ));
      },
    );
  }

  Widget loadingAndEventHandling(UserState state, BuildContext context) {
    if (state is UserStateInProgress) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("لطفا صبر کنید...")
          ],
        ),
      );
    } else if (state is UserStateError) {
      MSnackBar.Error(context);
    } else if (state is UserStateProgressComplete) {
      MSnackBar.Success(context);
    }
    return new Container(width: 0, height: 0);
  }
}

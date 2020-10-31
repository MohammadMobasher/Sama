import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sama/BloC/Login/LoginBloc.dart';
import 'package:sama/BloC/Login/LoginEvent.dart';
import 'package:sama/BloC/Login/LoginState.dart';
import 'package:sama/SamaBase/Constants.dart';
import 'package:sama/UI/Global/SButton.dart';
import 'package:sama/UI/Global/TextFieldBack.dart';
import 'package:sama/UI/Login/LoginBack.dart';
import 'package:sama/UI/Login/LoginPageLogic.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: globalKey,
        // usually avoid use this attribute
        //resizeToAvoidBottomInset: false,
        body: LoginForm());
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _loginForm();
  }
}

class _loginForm extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    final loginPageLogic = LoginPageLogic();

    _onLoginButtonPressed() {
      // MSnackBar.Success(context);
      BlocProvider.of<LoginBLoc>(context).add(
        LoginEventSubmitPress(
            userName: _usernameController.text,
            password: _passwordController.text),
      );
    }

    Size size = MediaQuery.of(context).size;
    // if (!IsFailure) {
    //   setState(() {
    //     MSnackBar.Success(context);
    //   });
    // }
    return BlocBuilder<LoginBLoc, LoginState>(builder: (context, state) {
      return LoginBack(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.25,
            ),
            Text(
              "سیما",
              style: TextStyle(fontSize: 20),
            ),
            Text("سامانه مکاتبات مرکز فقهی ائمه اطهار (ع)",
                style: TextStyle(fontSize: 12)),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: TextFieldBack(
                  // StreamBuilder<String>(
                  //   stream: loginPageLogic.userName,
                  //   builder: (context, snapshot) =>
                  child: TextField(
                controller: _usernameController,
                onChanged: loginPageLogic.userNameChange,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  //prefixIcon: Icon(Icons.account_circle),
                  prefixIcon: Icon(Icons.person),

                  hintText: "نام کاربری خود را وارد کنید",
                  labelText: "نام کاربری",
                ),
              )),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: TextFieldBack(
                    child: TextFormField(
                        controller: _passwordController,
                        onChanged: loginPageLogic.passwordChange,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: kPrimaryColor,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          //prefixIcon: Icon(Icons.remove_red_eye),
                          suffixIcon: Icon(Icons.remove_red_eye),
                          prefixIcon: Icon(Icons.vpn_key),
                          hintText: "کلمه عبور خود را وارد کنید",
                          labelText: "کلمه عبور",
                        )))),
            SButton(text: "ورود", press: _onLoginButtonPressed),
            Container(
              child: state is LoginStateInProgress
                  ? CircularProgressIndicator()
                  : null,
            )
          ],
        ),
      ));
    });
    // return BlocProvider(
    //   create: (context) {
    //     return BlocProvider.of<LoginBLoc>(context);
    //   },
    //   child:
  }
}

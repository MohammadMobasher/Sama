import 'package:sama/BloC/Login/LoginBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sama/UI/Global/SDrawer.dart';
import 'package:sama/Utilities/SamaAppBar.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return BlocProvider.of<LoginBLoc>(context);
      },
      child: Scaffold(
        appBar: SamaAppBar(),
        drawer: SDrawer(),
      ),
    );
  }
}

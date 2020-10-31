import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama/Model/User.dart';
import 'package:sama/Model/ViewModel/MessageSearchViewModel.dart';
import 'package:sama/UI/Global/SButton.dart';
import 'package:sama/UI/Global/SUserAutoComplete.dart';
import 'package:sama/UI/Global/TextFieldBack.dart';
import 'package:sama/UI/Message/MessagePage.dart';

class MessageSearch extends StatefulWidget {
  final MessageSearchViewModel vm;

  const MessageSearch({Key key, this.vm}) : super(key: key);

  @override
  _MessageSearchState createState() => _MessageSearchState();
}

class _MessageSearchState extends State<MessageSearch> {
  TextEditingController _titlecontroller;
  TextEditingController _textcontroller;
  User _selectedUser;

  @override
  void initState() {
    super.initState();
    _titlecontroller = TextEditingController(
        text: (widget.vm != null
            ? (widget.vm.title != null ? widget.vm.title : "")
            : ""));
    _textcontroller = TextEditingController(
        text: (widget.vm != null
            ? (widget.vm.text != null ? widget.vm.text : "")
            : ""));
    _selectedUser = (widget.vm != null
        ? (widget.vm.user != null ? widget.vm.user : null)
        : null);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(
              context,
              new MessageSearchViewModel(
                  title: this._titlecontroller.text,
                  text: this._titlecontroller.text,
                  user: _selectedUser));
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
//        : Icon(Icons.search),
            title: Text("جستجو در لیست نامه‌های دریافتی",
                style: TextStyle(fontSize: 13)),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                  child: new SafeArea(
                top: false,
                bottom: false,
                child: new SingleChildScrollView(
                  child: new Stack(
                    children: <Widget>[
                      new Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),

                                // new TextFormField(
                                //   obscureText: true,
                                //   keyboardType: TextInputType.visiblePassword,
                                //   style: TextStyle(
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                //   decoration: InputDecoration(
                                //     border: new OutlineInputBorder(
                                //         borderSide:
                                //             new BorderSide(color: Colors.black)),
                                //     // border: InputBorder.none,
                                //     prefixIcon: Icon(Icons.person),
                                //     hintText: "عبارت مورد درنظر را وارد کنید",
                                //     labelText: " جستجو در نام و نام خانوادگی",
                                //   ),
                                // ),

                                TextFieldBack(
                                  child: TextFormField(
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    controller: _titlecontroller,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.title),
                                      hintText: "عبارت مورد درنظر را وارد کنید",
                                      labelText: " جستجو در عنوان ها",
                                    ),
                                  ),
                                ),
                                SUserAutoComplete(
                                  selectedUser:
                                      this._selectedUser as List<User>,
                                  onItemSelected: (List<User> users) {
                                    this._selectedUser = users.first;
                                  },
                                ),
                                // TextFieldBack(
                                //   child: TextFormField(
                                //     obscureText: true,
                                //     keyboardType: TextInputType.visiblePassword,
                                //     style: TextStyle(
                                //       fontSize: 12,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //     decoration: InputDecoration(
                                //       border: InputBorder.none,
                                //       prefixIcon: Icon(Icons.account_circle),
                                //       hintText: "عبارت مورد درنظر را وارد کنید",
                                //       labelText: " جستجو در نام و نام خانوادگی",
                                //     ),
                                // ),
                                // ),
                                // new TextFormField(
                                //   style: TextStyle(fontSize: 13),
                                //   keyboardType: TextInputType.text,
                                //   decoration: const InputDecoration(
                                //     contentPadding:
                                //         EdgeInsets.fromLTRB(8.0, 15.0, 11.0, 15.0),
                                //     border: OutlineInputBorder(),
                                //     prefixIcon: const Icon(Icons.person),
                                //     labelText: 'نام و نام خانوادگی',
                                //   ),
                                // ),
                                TextFieldBack(
                                  child: TextFormField(
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    controller: _textcontroller,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.assignment),
                                      hintText: "عبارت مورد درنظر را وارد کنید",
                                      labelText: " جستجو در متن",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // RaisedButton(
                  //   shape: RoundedRectangleBorder(
                  //       side: BorderSide(color: Colors.green)),
                  //   onPressed: () {},
                  //   color: Colors.green,
                  //   textColor: Colors.white,
                  //   child: Text("اعمال فیلتر", style: TextStyle(fontSize: 14)),
                  // ),
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.pop(context, new MessageSearchViewModel());
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label: Text(
                      "حذف فیلتر",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    textColor: Colors.white,
                    splashColor: Colors.red,
                    color: Colors.red,
                  ),
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          new MessageSearchViewModel(
                              title: this._titlecontroller.text,
                              text: this._textcontroller.text,
                              user: _selectedUser));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label: Text(
                      "اعمال فیلتر",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    textColor: Colors.white,
                    splashColor: Colors.red,
                    color: Colors.green,
                  ),

                  // RaisedButton(
                  //   shape:
                  //       RoundedRectangleBorder(side: BorderSide(color: Colors.red)),
                  //   onPressed: () {},
                  //   color: Colors.red,
                  //   textColor: Colors.white,
                  //   child: Text("حذف فیلتر".toUpperCase(),
                  //       style: TextStyle(fontSize: 14)),
                  // ),
                ],
              )
            ],
          ),
        ));
  }
}

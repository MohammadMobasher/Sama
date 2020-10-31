import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama/BloC/Message/MessageBloc.dart';
import 'package:sama/BloC/Message/MessageEvent.dart';
import 'package:sama/Model/User.dart';
import 'package:sama/Model/ViewModel/MessageInsertViewModel.dart';

import 'package:sama/SamaBase/Constants.dart';
import 'package:sama/UI/Global/SButton.dart';
import 'package:sama/UI/Global/SUserAutoComplete.dart';
import 'package:sama/UI/Global/TextFieldBack.dart';
import 'package:sama/Utilities/MSnackBar.dart';

import 'MessageInsertLogic.dart';

class InsertMessage extends StatefulWidget {
  @override
  _InsertMessageState createState() => _InsertMessageState();
}

class _InsertMessageState extends State<InsertMessage> {
  final key = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MessageBloc _messageBloc;
  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  List<User> _recipientUsers = new List<User>();
  List<User> _cc_recipients = new List<User>();
  List<User> _bcc_recipients = new List<User>();

  @override
  void initState() {
    super.initState();
    _messageBloc = BlocProvider.of<MessageBloc>(context);
    // _messageBloc.add(MessageEventFetchItem(messageId: widget.messaheId));
  }

  @override
  void dispose() {
    _titleController.clear();
    _textController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: key,
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Text("ارسال", style: TextStyle(fontSize: 13)),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
          child: buildBody(context),
        ));
  }

  Widget buildBody(BuildContext context) {
    final messageInsertLogic = MessageInsertLogic();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SUserAutoComplete(
                  labelText: "گیرنده",
                  onItemSelected: (List<User> users) {
                    setState(() {
                      this._recipientUsers = users;
                    });
                  }),
              SUserAutoComplete(
                  labelText: "رونوشت",
                  onItemSelected: (List<User> users) {
                    setState(() {
                      this._cc_recipients = users;
                    });
                  }),
              SUserAutoComplete(
                  labelText: "رونوشت مخفی",
                  onItemSelected: (List<User> users) {
                    setState(() {
                      this._bcc_recipients = users;
                    });
                  }),
              TextFieldBack(
                child: StreamBuilder<String>(
                  stream: messageInsertLogic.title,
                  builder: (context, snapshot) => TextFormField(
                    onChanged: messageInsertLogic.titleChange,
                    controller: this._titleController,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.title),
                        hintText: "عنوان پیام را وارد کنید",
                        labelText: "عنوان",
                        errorText: snapshot.error,
                        errorStyle: TextStyle(
                          fontSize: 12,
                        )),
                  ),
                ),
              ),
              TextFieldBack(
                  child: StreamBuilder<String>(
                stream: messageInsertLogic.text,
                builder: (context, snapshot) => TextFormField(
                  onChanged: messageInsertLogic.textChange,
                  controller: this._textController,
                  minLines: 10,
                  maxLines: 20,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.description),
                      hintText: "متن پیام را وارد کنید",
                      labelText: "متن پیام",
                      errorText: snapshot.error,
                      errorStyle: TextStyle(
                        fontSize: 12,
                      )),
                ),
              )),
            ],
          ),
        )),
        Container(
            color: Colors.grey[100],
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    StreamBuilder<bool>(
                        stream: messageInsertLogic.submitCheck,
                        builder: (context, snapshot) => SButton(
                              text: "ارسال",
                              color:
                                  // snapshot.hasData &&
                                  //         (this._recipientUsers != null &&
                                  //             this._recipientUsers.length > 0)
                                  //     // ?
                                  kPrimaryColor,
                              // : Colors.grey,
                              press: () async {
                                _onPressedSendBtn(context);
                                // ignore: unnecessary_statements
                                // (snapshot.hasData &&
                                //         (this._recipientUsers != null &&
                                //             this._recipientUsers.length > 0)
                                //     ?

                                //     : null);
                              },
                            ))
                  ],
                )
              ],
            ))
      ],
    );
  }

  void _onPressedSendBtn(BuildContext context) {
    bool canSubmit = true;
    if (this._recipientUsers == null || this._recipientUsers.length == 0) {
      canSubmit = false;
      MSnackBar.ErrorWithText(context, "لطفا گیرنده پیام را مشخص کنید");
    } else if (this._titleController.text.isEmpty) {
      if (canSubmit)
        MSnackBar.ErrorWithText(context, "لطفا فیلد عنوان را پر کنید");
      canSubmit = false;
    } else if (this._textController.text.isEmpty) {
      if (canSubmit)
        MSnackBar.ErrorWithText(context, "لطفا فیلد متن را پر کنید");
      canSubmit = false;
    }

    if (canSubmit) {
      List<int> recipientIds =
          this._recipientUsers.map((f) => f.userId).toList();
      List<int> cc_recipientIds =
          this._cc_recipients.map((f) => f.userId).toList();
      List<int> bbc_recipientIds =
          this._bcc_recipients.map((f) => f.userId).toList();
      _messageBloc.add(MessageEventInsert(
          vm: new MessageInsertViewModel(
              title: this._titleController.text,
              text: this._textController.text,
              recipients: recipientIds,
              ccRecipients: cc_recipientIds,
              bccRecipients: bbc_recipientIds)));

      Navigator.pop(context);
    }
  }
}

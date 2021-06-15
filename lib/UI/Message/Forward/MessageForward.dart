import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama/BloC/Message/MessageBloc.dart';
import 'package:sama/BloC/Message/MessageEvent.dart';
import 'package:sama/Model/User.dart';
import 'package:sama/Model/ViewModel/MessageForwardViewModel.dart';
import 'package:sama/Model/ViewModel/MessageInsertViewModel.dart';

import 'package:sama/SamaBase/Constants.dart';
import 'package:sama/UI/Global/SButton.dart';
import 'package:sama/UI/Global/SUserAutoComplete.dart';
import 'package:sama/UI/Global/TextFieldBack.dart';

import 'MessageForwardLogic.dart';

class MessageForward extends StatefulWidget {
  final int message_id;

  const MessageForward({Key key, this.message_id}) : super(key: key);

  @override
  _messageForward createState() => _messageForward();
}

class _messageForward extends State<MessageForward> {
  final key = new GlobalKey<ScaffoldState>();
  List<PlatformFile> _files = new List<PlatformFile>();
  MessageBloc _messageBloc;

  final _textController = TextEditingController();
  bool _hasData = false;
  List<User> _recipientUsers = new List<User>();

  @override
  void initState() {
    super.initState();
    _messageBloc = BlocProvider.of<MessageBloc>(context);
    // _textController.addListener(() {
    //   setState(() {
    //     this._hasData = true;
    //   });
    // });
    // _messageBloc.add(MessageEventFetchItem(messageId: widget.messaheId));
  }

  @override
  void dispose() {
    _textController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: key,
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Text("رونوشت", style: TextStyle(fontSize: 13)),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
          child: buildBody(context),
        ));
  }

  Widget buildBody(BuildContext context) {
    final messageForwardLogic = MessageForwardLogic();
    return SingleChildScrollView(
      child: SizedBox(
          height: (MediaQuery.of(context).size.height) - 100,
          child: Column(
            children: <Widget>[
              SUserAutoComplete(onItemSelected: (List<User> users) {
                setState(() {
                  this._recipientUsers = users;
                });
              }),
              TextFieldBack(
                child:
                    //   StreamBuilder<String>(
                    // stream: messageForwardLogic.text,
                    // builder: (context, snapshot) =>
                    TextFormField(
                  onChanged: (text) {
                    if (text.isNotEmpty && text.length > 0) {
                      setState(() {
                        this._hasData = true;
                      });
                    } else {
                      setState(() {
                        this._hasData = false;
                      });
                    }
                  },
                  controller: this._textController,
                  minLines: 10,
                  maxLines: 20,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.description),
                    hintText: "متن پیام را وارد کنید",
                    labelText: "متن پیام",
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  FilePickerResult result = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                  );
                  setState(() {
                    if (result != null) {
                      _files = result.files;
                    } else {
                      _files = null;
                    }
                  });
                },
                child: const Icon(Icons.attach_file),
              ),
              new ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: 30.0,
                    maxHeight: (_files.length > 1 ? 200.0 : 50),
                  ),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _files.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return ListTile(
                        leading: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Center(child: Text(index.toString())),
                        ),
                        title: Text(_files[index].name),
                      );
                    },
                  )),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:
                      // StreamBuilder<bool>(
                      //     stream: messageForwardLogic.submitCheck,
                      //     builder: (context, snapshot) =>
                      SButton(
                    text: "ارسال",
                    color: this._hasData &&
                            (this._recipientUsers != null &&
                                this._recipientUsers.length > 0)
                        ? kPrimaryColor
                        : Colors.grey,
                    press: () async {
                      // ignore: unnecessary_statements
                      (this._hasData &&
                              (this._recipientUsers != null &&
                                  this._recipientUsers.length > 0)
                          ? _onPressedSendBtn(context)
                          : null);
                      // MeeageRepository d = new MeeageRepository(
                      //     apiProvider: ApiProvider());
                      // List<User> ll = new List<User>();
                      // ll.add(new User(userId: 57));
                      // ll.add(new User(userId: 738));
                      // await d.Insert(new MessageInsertViewModel(
                      //     title: "محمد مبشر",
                      //     text: "محمد میشر",
                      //     recipients: ["57", "738"]));
                      // _messageBloc.add(event);
                      // snapshot.hasData
                      //     ? _onPressedChangePassBtn()
                      //     : null;
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }

  void _onPressedSendBtn(BuildContext context) {
    List<int> recipientIds = this._recipientUsers.map((f) => f.userId).toList();
    _messageBloc.add(MessageEventForward(
        vm: new MessageForwardViewModel(
            messageId: widget.message_id,
            text: this._textController.text,
            recipients: recipientIds,
            attachPath: ((this._files != null && this._files.length > 0)
                ? this._files.first.path
                : ""))));

    Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName));
  }
}

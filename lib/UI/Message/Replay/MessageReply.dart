import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama/BloC/Message/MessageBloc.dart';
import 'package:sama/BloC/Message/MessageEvent.dart';
import 'package:sama/Model/ViewModel/MessageReplyViewModel.dart';

import 'package:sama/SamaBase/Constants.dart';
import 'package:sama/UI/Global/SButton.dart';
import 'package:sama/UI/Global/TextFieldBack.dart';

import 'MessageReplyLogic.dart';

class MessageReply extends StatefulWidget {
  final int message_id;

  const MessageReply({Key key, this.message_id}) : super(key: key);
  @override
  _messageReplyState createState() => _messageReplyState();
}

class _messageReplyState extends State<MessageReply> {
  List<PlatformFile> _files = new List<PlatformFile>();
  final key = new GlobalKey<ScaffoldState>();
  MessageBloc _messageBloc;

  final _textController = TextEditingController();
  bool _hasData = false;

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
          title: Text("پاراف", style: TextStyle(fontSize: 13)),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
          child: buildBody(context),
        ));
  }

  Widget buildBody(BuildContext context) {
    final messageReplyLogic = MessageReplyLogic();
    return SingleChildScrollView(
      child: SizedBox(
          height: (MediaQuery.of(context).size.height) - 100,
          child: Column(
            children: <Widget>[
              // TextFieldBack(
              //   child: StreamBuilder<String>(
              //     stream: messageReplyLogic.title,
              //     builder: (context, snapshot) => TextFormField(
              //       onChanged: messageReplyLogic.titleChange,
              //       controller: this._titleController,
              //       style: TextStyle(
              //         fontSize: 12,
              //         fontWeight: FontWeight.bold,
              //       ),
              //       decoration: InputDecoration(
              //           border: InputBorder.none,
              //           prefixIcon: Icon(Icons.title),
              //           hintText: "عنوان پیام را وارد کنید",
              //           labelText: "عنوان",
              //           errorText: snapshot.error,
              //           errorStyle: TextStyle(
              //             fontSize: 12,
              //           )),
              //     ),
              //   ),
              // ),
              TextFieldBack(
                child:
                    //   StreamBuilder<String>(
                    // stream: messageReplyLogic.text,
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
                        //     stream: messageReplyLogic.submitCheck,
                        //     builder: (context, snapshot) =>
                        SButton(
                      text: "ارسال",
                      color: this._hasData ? kPrimaryColor : Colors.grey,
                      press: () async {
                        // ignore: unnecessary_statements
                        (this._hasData ? _onPressedSendBtn(context) : null);
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
                    )),
              ),
              // )
            ],
          )),
    );
  }

  void _onPressedSendBtn(BuildContext context) {
    _messageBloc.add(MessageEventReply(
        vm: new MessageReplyViewModel(
            text: this._textController.text,
            messageId: widget.message_id,
            attachPath: ((this._files != null && this._files.length > 0)
                ? this._files.first.path
                : ""))));

    Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName));
  }
}

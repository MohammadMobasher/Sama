import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sama/BloC/Message/MessageBloc.dart';
import 'package:sama/SamaBase/Network/Downloader.dart';
import 'package:sama/Utilities/MCheckPermision.dart';
import 'package:sama/BloC/Message/MessageEvent.dart';
import 'package:sama/BloC/Message/MessageState.dart';
import 'package:sama/UI/Message/Forward/MessageForward.dart';
import 'package:sama/UI/Message/Replay/MessageReply.dart';
import 'package:sama/Utilities/MSnackBar.dart';
import 'package:shamsi_date/shamsi_date.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class MessageShowIncomming extends StatefulWidget {
  final int messaheId;

  const MessageShowIncomming({Key key, this.messaheId}) : super(key: key);

  @override
  _MessageShowState createState() => _MessageShowState();
}

class _MessageShowState extends State<MessageShowIncomming> {
  MessageBloc _messageBloc;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    // final iOS = IOSInitializationSettings();
    // final initSettings = InitializationSettings(android, iOS);

    // flutterLocalNotificationsPlugin.initialize(initSettings,
    //     onSelectNotification: _onSelectNotification);

    _messageBloc = BlocProvider.of<MessageBloc>(context);
    _messageBloc.add(MessageEventFetchItem(messageId: widget.messaheId));
  }

  Future<void> _onSelectNotification(String json) async {
    // todo: handling clicked notification
  }
  Widget loadPage(MessageState state, BuildContext context1) {
    if (state is MessageStateUninitialized) {
      return Center(child: CircularProgressIndicator());
    } else if (state is MessageStateLoaded) {
      if (state.message == null) {
        return Center(child: CircularProgressIndicator());
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      state.message.title,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      state.message.sender != null
                          ? (state.message.sender.fullname.trim() +
                              " " +
                              state.message.sender.lastname.trim())
                          : "",
                      style: TextStyle(fontSize: 12, color: Colors.green[800]),
                    ),
                    // Text(
                    //     format1(Jalali.fromDateTime(state.message.date)) +
                    //         " " +
                    //         state.message.date.hour.toString() +
                    //         ":" +
                    //         state.message.date.minute.toString(),
                    //     style: TextStyle(
                    //       fontSize: 12.0,
                    //     )),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      state.message.sender != null
                          ? ((state.message.sender.deputy?.title ?? "") +
                              " | " +
                              (state.message.sender.part?.title ?? "") +
                              " | " +
                              (state.message.sender.post?.title ?? ""))
                          : "",
                      style: TextStyle(fontSize: 10, color: Colors.blue[300]),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                color: Colors.white,
                child:
                    //  WebView(
                    //   initialUrl: Uri.dataFromString(
                    //     state.message.text,
                    //     mimeType: 'text/html',
                    //   ).toString(),
                    //   javascriptMode: JavascriptMode.unrestricted,
                    // ),
                    Html(data: state.message.text),
              ),
              (state.message.mainAttach != null &&
                      state.message.attaches.length > 0
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      // padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400])),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.attach_file),
                                Text(
                                  "پیوست اصل پیام",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          new ConstrainedBox(
                            constraints: new BoxConstraints(
                              minHeight: 30.0,
                              maxHeight: (state.message.mainAttach.length > 1
                                  ? 200.0
                                  : 60),
                            ),
                            child: ListView.builder(
                                itemCount: state.message.mainAttach.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.insert_drive_file,
                                      size: 35,
                                    ),
                                    title: Align(
                                      child: new Text(
                                          state.message.mainAttach[index]
                                              .uploadName,
                                          style: TextStyle(fontSize: 13)),
                                      alignment: Alignment(1.2, 0),
                                    ),
                                    onTap: () async {
                                      if (await MCheckPermision
                                          .requestPermissions(
                                              Permission.storage)) {
                                        Downloader d = new Downloader();
                                        d.download(
                                            state.message.mainAttach[index].url,
                                            context);
                                      } else {
                                        MSnackBar.ErrorWithText(context,
                                            "لطفا دسرتسی لازم را به برنامه بدهید");
                                      }
                                    },
                                  );
                                }),
                            // ListView(
                            //   children: [
                            //     Builder(
                            //         builder: (context) => ListTile(
                            //               onTap: () async {
                            //                 if (await MCheckPermision
                            //                     .requestPermissions(
                            //                         Permission.storage)) {
                            //                   Downloader d = new Downloader();
                            //                   d.download(
                            //                       "http://lot.services/blog/files/DSCF0277.jpg",
                            //                       context);
                            //                 } else {
                            //                   MSnackBar.ErrorWithText(context,
                            //                       "لطفا دسرتسی لازم را به برنامه بدهید");
                            //                 }
                            //               },
                            //               leading: Icon(Icons.ac_unit),
                            //               title: Text("mohammad"),
                            //             ))
                            //   ],
                            // ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    )),
              (state.message.attaches != null &&
                      state.message.attaches.length > 0
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      // padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400])),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.attach_file),
                                Text(
                                  "پیوست جدید",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          new ConstrainedBox(
                            constraints: new BoxConstraints(
                              minHeight: 30.0,
                              maxHeight: (state.message.attaches.length > 1
                                  ? 200.0
                                  : 60),
                            ),
                            child: ListView.builder(
                                itemCount: state.message.attaches.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.insert_drive_file,
                                      size: 35,
                                    ),
                                    title: Align(
                                      child: new Text(
                                          state.message.attaches[index]
                                              .uploadName,
                                          style: TextStyle(fontSize: 13)),
                                      alignment: Alignment(1.2, 0),
                                    ),
                                    onTap: () async {
                                      if (await MCheckPermision
                                          .requestPermissions(
                                              Permission.storage)) {
                                        Downloader d = new Downloader();
                                        d.download(
                                            state.message.attaches[index].url,
                                            context);
                                      } else {
                                        MSnackBar.ErrorWithText(context,
                                            "لطفا دسرتسی لازم را به برنامه بدهید");
                                      }
                                    },
                                  );
                                }),
                            // ListView(
                            //   children: [
                            //     Builder(
                            //         builder: (context) => ListTile(
                            //               onTap: () async {
                            //                 if (await MCheckPermision
                            //                     .requestPermissions(
                            //                         Permission.storage)) {
                            //                   Downloader d = new Downloader();
                            //                   d.download(
                            //                       "http://lot.services/blog/files/DSCF0277.jpg",
                            //                       context);
                            //                 } else {
                            //                   MSnackBar.ErrorWithText(context,
                            //                       "لطفا دسرتسی لازم را به برنامه بدهید");
                            //                 }
                            //               },
                            //               leading: Icon(Icons.ac_unit),
                            //               title: Text("mohammad"),
                            //             ))
                            //   ],
                            // ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ))
            ],
          ))),
          Container(
              color: Colors.grey[100],
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                          child: RaisedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<MessageShowIncomming>(
                              builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<MessageBloc>(context),
                                child:
                                    MessageReply(message_id: widget.messaheId),
                              ),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        label: Text(
                          "پاسخ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        icon: Icon(
                          Icons.reply,
                          color: Colors.white,
                        ),
                        textColor: Colors.white,
                        splashColor: Colors.green[300],
                        color: Colors.green[300],
                      )),
                      Flexible(
                        child: RaisedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<MessageShowIncomming>(
                                builder: (_) => BlocProvider.value(
                                  value: BlocProvider.of<MessageBloc>(context),
                                  child: MessageForward(
                                      message_id: widget.messaheId),
                                ),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          label: Text(
                            "رونوشت",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          icon: Icon(
                            Icons.forward,
                            color: Colors.white,
                          ),
                          textColor: Colors.white,
                          splashColor: Colors.green[300],
                          color: Colors.green[300],
                        ),
                      )
                    ],
                  )
                ],
              )),
        ],
      );
    }
    return Text("mohammad");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
//        : Icon(Icons.search),
          title: Text("نمایش", style: TextStyle(fontSize: 13)),
        ),
        backgroundColor: Colors.grey[300],

        //resizeToAvoidBottomInset: false,
        body: loadPage(state, context),
      );
    });
  }

  String format1(Date d) {
    final f = d.formatter;

    return '${f.wN} ${f.d} ${f.mN} ${f.yyyy}';
  }
}

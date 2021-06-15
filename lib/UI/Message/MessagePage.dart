import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sama/BloC/Login/LoginBloc.dart';
import 'package:sama/BloC/Login/LoginState.dart';
import 'package:sama/BloC/Message/MessageBloc.dart';
import 'package:sama/BloC/Message/MessageEvent.dart';
import 'package:sama/BloC/Message/MessageState.dart';
import 'package:sama/Model/Message.dart';
import 'package:sama/Model/Receiver.dart';
import 'package:sama/Model/ViewModel/MessageSearchViewModel.dart';
import 'package:sama/UI/Message/Insert/InsertMessage.dart';
import 'package:sama/UI/Message/MessageListItem.dart';
import 'package:sama/UI/Message/MessageSearch.dart';
import 'package:sama/UI/Global/SDrawer.dart';

import 'package:sama/Utilities/MSnackBar.dart';
import 'package:sama/Utilities/MTabBNB.dart';
import 'package:sama/Utilities/SamaAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MessageShowIncomming.dart';
import 'MessageShowSend.dart';

class MessagePage extends StatefulWidget {
  final MessageSearchViewModel vm;

  const MessagePage({Key key, this.vm}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  MessageSearchViewModel vm;
  SharedPreferences sharedPrefs;
  int _currentTypeMessage = 0;
  final _scrollController = ScrollController();
  int _pageIncomming = 1;
  int newItemIncomming = 1;

  bool _hasSearchValue = false;
  int _pageSend = 1;
  int perPage = 40;
  List<Message> data = new List<Message>();
  MessageBloc _messageBloc;

  @override
  void initState() {
    super.initState();
    this.vm = MessageSearchViewModel();
    this._scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      // if (maxScroll - currentScroll <= this._scrollThreshold) {
      if (maxScroll == currentScroll) {
        // setState(() {
        if (this._currentTypeMessage == 0) {
          this._pageIncomming += 1;
          BlocProvider.of<MessageBloc>(context).add(MessageEventFetchIncomming(
              page: this._pageIncomming, vm: this.vm));
        } else {
          this._pageSend += 1;
          BlocProvider.of<MessageBloc>(context)
              .add(MessageEventFetchSend(page: this._pageSend, vm: this.vm));
        }
        // });
      }
    });
    _messageBloc = BlocProvider.of<MessageBloc>(context);

    if (_currentTypeMessage == 0) {
      _messageBloc.add(
          MessageEventFetchIncomming(page: this._pageIncomming, vm: this.vm));
    } else {
      _messageBloc
          .add(MessageEventFetchSend(page: this._pageSend, vm: this.vm));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBLoc, LoginState>(builder: (context, state) {
      return state == LoginStateSuccess()
          ? new Scaffold(
              backgroundColor: Colors.grey[200],
              drawer: SDrawer(),
              appBar: SamaAppBar(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add_comment),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<MessageShowIncomming>(
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<MessageBloc>(context),
                          child: InsertMessage(),
                        ),
                      ),
                    );

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => InsertMessage()));
                  }),
              bottomNavigationBar: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MTabBNB(
                        onTap: () {
                          setState(() {
                            if (this._currentTypeMessage != 0) {
                              this._currentTypeMessage = 0;
                              this._hasSearchValue = false;
                              this.vm = null;
                              _messageBloc.add(MessageEventFetchIncomming(
                                  page: this._pageIncomming,
                                  vm: this.vm,
                                  refreshList: true));
                            }
                          });
                        },
                        icon: Icons.move_to_inbox,
                        title: "دریافتی",
                        isSelected: (_currentTypeMessage == 0 ? true : false),
                      ),
                      MTabBNB(
                        onTap: () {
                          setState(() {
                            if (this._currentTypeMessage != 1) {
                              this._currentTypeMessage = 1;
                              this._hasSearchValue = false;
                              this.vm = null;
                              _messageBloc.add(MessageEventFetchSend(
                                  page: this._pageSend, vm: this.vm));
                            }
                          });
                        },
                        icon: Icons.launch,
                        title: "ارسالی",
                        isSelected: (_currentTypeMessage == 1 ? true : false),
                      )
                    ],
                  )),
              body: BlocBuilder<MessageBloc, MessageState>(
                  builder: (context, state) {
                return Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(width: 0.4, color: Colors.grey),
                          )),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: FlatButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.text_rotation_angleup,
                                  color: Colors.blue[900],
                                  // color: Colors.amber[700],
                                ),
                                label: Text("خوانده",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black))),
                          ),
                          Container(
                              height: 40,
                              child: VerticalDivider(color: Colors.grey)),
                          GestureDetector(
                            onLongPress: _showCustomMenu,
                            onTapDown: _storePosition,
                            child: FlatButton.icon(
                                onPressed: () async {},
                                icon: Icon(
                                  Icons.sort,
                                  color: Colors.blue[900],
                                  // color: Colors.amber[700],
                                ),
                                label: Text("مرتب‌سازی",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black))),
                          ),
                          Container(
                              height: 40,
                              child: VerticalDivider(color: Colors.grey)),
                          FlatButton.icon(
                              onPressed: () async {
                                openMessageSearchPage();
                              },
                              icon: Icon(Icons.search,
                                  color: this._hasSearchValue
                                      ? Colors.amber[700]
                                      : Colors.blue[900]

                                  // (this.vm != null
                                  //     ? (this.vm.title != null ||
                                  //             this.vm.text != null ||
                                  //             this.vm.user != null
                                  //         ? Colors.amber[700]
                                  //         : Colors.blue[900])
                                  //     : Colors.blue[900]),
                                  // ,
                                  ),
                              label: Text("جستجو",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black))),
                        ],
                      ),
                    ),
                    Expanded(
                        child: RefreshIndicator(
                            // key: _refreshIndicatorKey,
                            child: Stack(
                              children: <Widget>[
                                (this._currentTypeMessage == 0
                                    ? buildListIncommingMessage(state)
                                    : buildListSendMessage(state))
                              ],
                            ),
                            onRefresh: _refresh))
                  ],
                );
              })
              // new Scrollbar(
              // child:

              )
          : Text("mohammad");
    });
  }

  var _count = 0;
  var _tapPosition;

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _showCustomMenu() {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    showMenu(
        context: context,
        position: RelativeRect.fromRect(
            _tapPosition & Size(40, 40), // smaller rect, the touch area
            Offset.zero & overlay.size // Bigger rect, the entire screen
            ),
        items: <PopupMenuItem<String>>[
          new PopupMenuItem<String>(child: const Text('test1'), value: 'test1'),
          new PopupMenuItem<String>(child: const Text('test2'), value: 'test2'),
        ]);
  }

  Widget buildListIncommingMessage(MessageState state) {
    if (state is MessageStateUninitialized) {
      // BlocProvider.of<MessageBloc>(context)
      //     .add(MessageEventFetch(page: this._page));
      // _messageBloc.add(MessageEventFetch(page: this._page));
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is MessageStateInsert ||
        state is MessageStateReply ||
        state is MessageStateForward) {
      return showStuffAfterInsertAndReplyMessage();
    }
    if (state is MessageStateError) {
      return SingleChildScrollView(
          //physics: AlwaysScrollableScrollPhysics(),
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Text('خطایی رخ داده است، لطفا بعدا تلاش کنید...'),
              )));
    }
    final mstate = state as MessageStateLoaded;
    if (mstate.messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.inbox,
              color: Colors.red,
              size: 50,
            ),
            Text('پیامی وجود ندارد.')
          ],
        ),
      );
    }
    if (mstate.messageType == 1) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
          ],
        ),
      );
    }
    return new ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, position) {
        if (position == mstate.messages.length) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          );
          //CupertinoActivityIndicator();
        }
        Message message = mstate.messages[position];
        return InkWell(
            onTap: () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute<MessageShowIncomming>(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<MessageBloc>(context),
                    child: MessageShowIncomming(messaheId: message.mailId),
                  ),
                ),
              );
              refreshListBackToPage();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute<MessageShow>(
              //         builder: (context) => MessageShow(
              //               messaheId: message.mailId,
              //             )));
            },
            child: MessageListItem(
              imageURL: message.sender?.pathCover ?? "",
              fullName: message.sender != null
                  ? (message.sender.fullname.trim() +
                      " " +
                      message.sender.lastname.trim())
                  : "ناشناس",

              date: message.date,
              title: message.title,
              isSeen: message.isSeen,
              post: message.sender != null
                  ? ((message.sender.deputy?.title ?? "") +
                      " | " +
                      (message.sender.part?.title ?? "") +
                      " | " +
                      (message.sender.post?.title ?? ""))
                  : "ناشناس",
              //message.quoteText,
            ));
        // new Text(
        //   // items[index] + "$index"
        //   mstate.messages[index].title + "$index"
        //   );
      },
      itemCount: mstate.messages.length,
    );
    // setState(() {

    // });
  }

  Widget buildListSendMessage(MessageState state) {
    if (state is MessageStateUninitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is MessageStateInsert ||
        state is MessageStateReply ||
        state is MessageStateForward) {
      return showStuffAfterInsertAndReplyMessage();
    }

    if (state is MessageStateError) {
      return SingleChildScrollView(
          //physics: AlwaysScrollableScrollPhysics(),
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Text('خطایی رخ داده است، لطفا بعدا تلاش کنید...'),
              )));
    }
    final mstate = state as MessageStateLoaded;

    if (mstate.messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.inbox,
              color: Colors.red,
              size: 50,
            ),
            Text('پیامی وجود ندارد.')
          ],
        ),
      );
    }
    if (mstate.messageType == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
          ],
        ),
      );
    }
    var list = new ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, position) {
        if (position == mstate.messages.length) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text("درحال بارگزاری اطلاعات...")
            ],
          );
          //CupertinoActivityIndicator();
        }
        Message message = mstate.messages[position];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<MessageShowSend>(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<MessageBloc>(context),
                  child: MessageShowSend(messaheId: message.mailId),
                ),
              ),
            );
          },
          child: MessageListItem(
              imageURL: (message.receivers.length > 1
                  ? ""
                  : message.receivers.first.user.pathCover),
              fullName: getNameFromReciverList(message.receivers),
              date: message.date,
              title: message.title,
              isSeen: false,
              post: ""
              //message.quoteText,
              ),
        );
        // new Text(
        //   // items[index] + "$index"
        //   mstate.messages[index].title + "$index"
        //   );
      },
      itemCount: mstate.messages.length,
    );
    return list;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<Null> _refresh() async {
    // BlocProvider.of<MessageBloc>(context)
    //     .add(MessageEventFetch(page: this._page));
    setState(() {
      _messageBloc.add((this._currentTypeMessage == 0
          ? MessageEventFetchIncomming(
              page: this._pageIncomming, vm: this.vm, refreshList: true)
          : MessageEventFetchSend(
              page: this._pageSend, vm: this.vm, refreshList: true)));
    });
    return null;
  }

  void openMessageSearchPage() async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MessageSearch(vm: this.vm)));
    getDataFromMessageSearchPage(result);
  }

  void getDataFromMessageSearchPage(MessageSearchViewModel vm) {
    setState(() {
      this.vm = vm;
      hasSearchValue();
      if (_currentTypeMessage == 0) {
        _messageBloc.add(MessageEventFetchIncomming(
            page: this._pageIncomming, vm: this.vm, refreshList: true));
      } else {
        _messageBloc.add(MessageEventFetchSend(
            page: this._pageSend, vm: this.vm, refreshList: true));
      }
    });
  }

  void refreshListBackToPage() {
    setState(() {
      this.vm = vm;
      _messageBloc.add(MessageEventFetchIncomming(
          page: this._pageIncomming, vm: this.vm, refreshList: true));
    });
  }

  void hasSearchValue() {
    if (this.vm != null) {
      if (this.vm.title != null ||
          this.vm.user != null ||
          this.vm.user != null) {
        this._hasSearchValue = true;
      } else {
        this._hasSearchValue = false;
      }
    } else {
      this._hasSearchValue = false;
    }
  }

  Widget showStuffAfterInsertAndReplyMessage() {
    Future.delayed(Duration.zero, () async {
      MSnackBar.Success(context);
    });

    if (_currentTypeMessage == 0) {
      _messageBloc.add(MessageEventFetchIncomming(
          page: this._pageIncomming, vm: this.vm, refreshList: true));
    } else {
      _messageBloc.add(MessageEventFetchSend(
          page: this._pageSend, vm: this.vm, refreshList: true));
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  String getNameFromReciverList(List<Receiver> recivers) {
    String result = "";
    if (recivers.length > 1) {
      result = recivers.first.user.fullname +
          " " +
          recivers.first.user.lastname +
          "، ";
      result += recivers[1].user.fullname + " " + recivers[1].user.lastname;
    } else {
      result =
          recivers.first.user.fullname + " " + recivers.first.user.lastname;
    }
    return result;
  }

  bool allReciversSeeMessage(List<Receiver> recivers) {
    recivers.map((f) => f.isSeen).toList();
  }

  // String getPostFromReciverList(List<Receiver> recivers) {
  //   String result = "";
  //   if (recivers.length > 1) {
  //     result = recivers.first.user.fullname +
  //         " " +
  //         recivers.first.user.lastname +
  //         "، ";
  //     result += recivers[1].user.fullname + recivers[1].user.lastname;
  //   } else {
  //     result =
  //         recivers.first.dep + " " + recivers.first.user.lastname;
  //   }
  //   return result;
  // }
}

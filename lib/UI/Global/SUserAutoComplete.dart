import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama/Model/User.dart';
import 'package:sama/Repository/UserRepository.dart';
import 'package:sama/SamaBase/Network/ApiProvider.dart';
import 'package:sama/SamaBase/SamaExtension/SColor.dart';
import 'package:sama/Utilities/MLinearProgressBar.dart';

import 'TextFieldBack.dart';

class SUserAutoComplete extends StatefulWidget {
  final Function onItemSelected;
  final List<User> selectedUser;
  final String labelText;

  const SUserAutoComplete(
      {Key key, this.onItemSelected, this.selectedUser, this.labelText})
      : super(key: key);

  @override
  _SUserAutoCompleteState createState() => _SUserAutoCompleteState();
}

class _SUserAutoCompleteState extends State<SUserAutoComplete> {
  List<User> selectedForSend = new List<User>();
  final TextEditingController _searchQueryController =
      new TextEditingController();
  final FocusNode _focusNode = new FocusNode();
  UserRepository _userRepository;
  bool _isSearching = true;
  bool _showProgress = false;
  String _searchText = "";
  List<User> _searchList = List();
  bool _onTap = false;
  int _onTapTextLength = 0;

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    _userRepository = new UserRepository(apiProvider: new ApiProvider());
    if (widget.selectedUser != null) {
      this.selectedForSend = widget.selectedUser;
    }
  }

  @override
  void dispose() {
    _searchQueryController.dispose();
    super.dispose();
  }

  _SUserAutoCompleteState() {
    _searchQueryController.addListener(() {
      if (_searchQueryController.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _showProgress = false;
          _searchText = "";
          _searchList = List();
        });
      } else {
        if (this._focusNode.hasFocus) {
          setState(() {
            _isSearching = true;
            _showProgress = false;
            _searchText = _searchQueryController.text;
            _onTap = _onTapTextLength == _searchText.length;
          });
        }
      }
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        //this._overlayEntry = this._createOverlayEntry();
        //Overlay.of(context).insert(this._overlayEntry);
      } else {
        setState(() {
          _isSearching = false;
          _searchText = "";
          _searchList = List();
        });
        if (this.overlayEntry != null) {
          // if (this.overlayEntry.hashCode != null) {
          this.overlayEntry.remove();
          this.overlayEntry = null;
          // }
        }
      }
    });
  }

  final LayerLink _layerLink = LayerLink();
  OverlayEntry overlayEntry;

  suggestionWidget(BuildContext context) async {
    if (this.overlayEntry != null) {
      // if (this.overlayEntry.hashCode != null) {
      this.overlayEntry?.remove();
      this.overlayEntry = null;
      // }
    }
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    OverlayState overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            left: offset.dx,
            top: offset.dy + size.height,
            width: size.width,
            child: Material(
                child: Container(
              child: getFutureWidget(),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: _isSearching && (!_onTap)
                          ? SColor.getColorFromHex("#EEEEEE")
                          : Colors.transparent)),
            ))));

    overlayState.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            MLinearProgressBar(
              height: 3,
              isActive: _isSearching,
            ),
            TextFieldBack(
              child: TextFormField(
                onChanged: (String value) {
                  if (value.isNotEmpty) {
                    suggestionWidget(context);
                  } else {
                    overlayEntry.remove();
                  }
                },
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                controller: _searchQueryController,
                keyboardType: TextInputType.text,
                focusNode: _focusNode,
                onFieldSubmitted: (String value) {
                  print("$value submitted");
                  setState(() {
                    _searchQueryController.text = value;
                    _onTap = true;
                  });
                },
                onSaved: (String value) => print("$value saved"),
                // decoration: const InputDecoration(
                //   contentPadding: EdgeInsets.fromLTRB(8.0, 15.0, 5.0, 15.0),
                //   border: OutlineInputBorder(),
                //   prefixIcon: const Icon(Icons.supervised_user_circle),
                //   labelText: 'ارسال به',
                // ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.supervised_user_circle),
                  hintText: "عبارت مورد درنظر را وارد کنید",
                  labelText: widget.labelText != null
                      ? widget.labelText
                      : "جستجو در نام و نام خانوادگی",
                ),
              ),
            )
          ],
        ),
        ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200, minHeight: 0.0),
            child: Container(
              // padding: const EdgeInsets.all(6),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.grey),
              // ),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectedForSend.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedForSend.removeAt(i);
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.cancel,
                            size: 18.0,
                            color: Colors.red,
                          ),
                          Text(
                            selectedForSend[i].lastname,
                            style: TextStyle(fontSize: 13.0),
                          )
                        ],
                      ),
                    );
                    // ListTile(
                    //   leading: Icon(Icons.cancel),
                    //   title: Text(selectedForSend[i].lastname),
                    // );
                  }),
            ))
      ],
    );
  }

  Widget getFutureWidget() {
    return new FutureBuilder(
        future: _buildSearchList(),
        initialData: List<ListTile>(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ListTile>> childItems) {
          return new Container(
            color: Colors.white,
            height: 180,
            //getChildren(childItems).length * 52.0,
            width: MediaQuery.of(context).size.width,
            child:
                //Text("mohammad"),
                new ListView(
              padding: new EdgeInsets.only(right: 5.0),
              children: childItems.data != null
                  ? ListTile.divideTiles(
                          context: context, tiles: getChildren(childItems))
                      .toList()
                  : List(),
            ),
          );
        });
  }

  List<ListTile> getChildren(AsyncSnapshot<List<ListTile>> childItems) {
    if (_onTap && _searchText.length != _onTapTextLength) _onTap = false;
    List<ListTile> childrenList =
        _isSearching && !_onTap ? childItems.data : List();
    return childrenList;
  }

  ListTile _getListTile(User user) {
    return new ListTile(
      dense: true,
      leading: ClipRRect(
          child: (user.pathCover != null && user.pathCover.isNotEmpty
              ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 43,
                  width: 43,
                  imageUrl:
                      //"https://www.talkwalker.com/images/2020/blog-headers/image-analysis.png",
                      user.pathCover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      'assets/images/no-user.png',
                      fit: BoxFit.cover,
                      height: 43,
                      width: 43,
                    );
                  },
                )
              : new Image.asset(
                  'assets/images/no-user.png',
                  fit: BoxFit.cover,
                  height: 43,
                  width: 43,
                )),
          borderRadius: BorderRadius.circular(40)),
      title: new Text(
        user.fullname + " " + user.lastname,
        //style: Theme.of(context).textTheme.body2,
      ),
      subtitle: Text(getPartPostDeputy(user)),
      onTap: () {
        setState(() {
          this.overlayEntry.remove();
          this.overlayEntry = null;
          _onTap = true;
          _searchQueryController.text = "";
          _isSearching = false;
          setState(() {
            selectedForSend.add(user);
          });
          widget.onItemSelected(selectedForSend);
        });
        // _searchQueryController.selection =
        //     TextSelection.fromPosition(new TextPosition(offset: 9));
      },
    );
  }

  Future<List<ListTile>> _buildSearchList() async {
    if (_searchText.isEmpty) {
      _searchList = List();
      return List();
    } else {
      //_searchList = await _getSuggestion(_searchText) ?? List();
      // setState(() {
      //   _showProgress = true;
      // });
      _searchList = await _userRepository.searchByName(_searchText);
      // setState(() {
      //   _showProgress = false;
      // });
      //_isSearching = false;
//        ..add(_searchText);

      List<ListTile> childItems = new List();
      for (User value in _searchList) {
        childItems.add(_getListTile(value));
      }
      return childItems;
    }
  }

  String getPartPostDeputy(User user) {
    String result = "";
    if (user.deputy != null) {
      result += user.deputy.title + "/";
    }
    if (user.part != null) result += user.part.title + "/";

    if (user.post != null) result += user.post.title;

    return result;
  }
}

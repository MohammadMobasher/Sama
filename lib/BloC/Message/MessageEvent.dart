import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama/Model/ViewModel/MessageForwardViewModel.dart';
import 'package:sama/Model/ViewModel/MessageInsertViewModel.dart';
import 'package:sama/Model/ViewModel/MessageReplyViewModel.dart';
import 'package:sama/Model/ViewModel/MessageSearchViewModel.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
}

class MessageEventFetchItem extends MessageEvent {
  final int messageId;
  final int messageType;

  MessageEventFetchItem({@required this.messageId, this.messageType = 0});

  @override
  List<Object> get props => [this.messageId, this.messageType];
}

class MessageEventForward extends MessageEvent {
  final MessageForwardViewModel vm;

  MessageEventForward({@required this.vm});

  @override
  List<Object> get props => [this.vm];
}

class MessageEventReply extends MessageEvent {
  final MessageReplyViewModel vm;

  MessageEventReply({@required this.vm});

  @override
  List<Object> get props => [this.vm];
}

class MessageEventInsert extends MessageEvent {
  final MessageInsertViewModel vm;

  MessageEventInsert({@required this.vm});

  @override
  List<Object> get props => [this.vm];
}

class MessageEventFetchIncomming extends MessageEvent {
  final int page;
  final MessageSearchViewModel vm;
  final bool refreshList;

  const MessageEventFetchIncomming(
      {@required this.page, @required this.vm, this.refreshList = false});

  @override
  List<Object> get props => [page];
}

class MessageEventFetchSend extends MessageEvent {
  final int page;
  final MessageSearchViewModel vm;
  final bool refreshList;

  const MessageEventFetchSend(
      {@required this.page, @required this.vm, this.refreshList = false});

  @override
  List<Object> get props => [page];
}

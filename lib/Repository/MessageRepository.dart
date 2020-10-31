import 'package:flutter/cupertino.dart';
import 'package:sama/Model/Message.dart';
import 'package:sama/Model/ViewModel/MessageForwardViewModel.dart';
import 'package:sama/Model/ViewModel/MessageInsertViewModel.dart';
import 'package:sama/Model/ViewModel/MessageReplyViewModel.dart';
import 'package:sama/Model/ViewModel/MessageSearchViewModel.dart';
import 'package:sama/SamaBase/Network/ApiProvider.dart';
import 'package:sama/SamaBase/Network/NetworkRespons.dart';

class MeeageRepository {
  final ApiProvider apiProvider;

  MeeageRepository({@required this.apiProvider}) : assert(apiProvider != null);

  Future<bool> Forward(MessageForwardViewModel vm) async {
    String url = "mail/" + vm.messageId.toString() + "/set-bookmark";
    var result = await apiProvider.post(url, body: vm.toJson());
    if (result.status != Status.ERROR) {
      return true;
    }
    return false;
  }

  Future<bool> Reply(MessageReplyViewModel vm) async {
    String url = "mail/" + vm.messageId.toString() + "/reply";
    var result = await apiProvider.post(url, body: vm.toJson());
    if (result.status != Status.ERROR) {
      return true;
    }
    return false;
  }

  Future<bool> Insert(MessageInsertViewModel vm) async {
    String url = "mail/compose";

    var result = await apiProvider.post(url, body: vm.toJson());
    if (result.status != Status.ERROR) {
      return true;
    }
    return false;
  }

  Future<Message> getItem(int messageId, {messageType = 0}) async {
    String url = "";
    if (messageType == 0)
      url = "mail/$messageId/show";
    else
      url = "mail/$messageId/sent";
    var result = await apiProvider.get(url);
    return Message.fromJson(result.data);
  }

  Future<List<Message>> fetchIncommingMessage(
      {int page = 1, MessageSearchViewModel vm}) async {
    List<Message> messages;
    String url = "mail/inbox?page=$page&per_page=20";
    if (vm != null) {
      if (vm.title != null && vm.title.isNotEmpty) url += "&title=" + vm.title;
      if (vm.user != null && vm.user != null) {
        url += "&sender=" + vm.user.userId.toString();
      }
      if (vm.text != null && vm.text.isNotEmpty) url += "&text=" + vm.text;
    }

    var result = await apiProvider.get(url);
    if (result.status != Status.ERROR) {
      messages = (result.data['data'] as List)
          .map((item) => Message.fromJson(item))
          .toList();
    }
    return messages;
  }

  Future<int> getNumberOfNewMessage() async {
    var messageId =
        // MPref.getString("LastMessageId");
        "28183";
    // MPref.getString("LastMessageId");
    if (messageId != null && messageId.isNotEmpty) {
      String url = "mail/new-messages-count?last_id=$messageId";
      var result = await apiProvider.get(url);
      if (result.status != Status.ERROR) {
        return 10; //result.data["count"];
      }
    }
    return 11;
  }

  Future<List<Message>> fetchSendMessage(
      {int page = 1, MessageSearchViewModel vm}) async {
    List<Message> messages;
    String url = "mail/sent?page=$page&per_page=20";
    if (vm != null) {
      if (vm.title != null && vm.title.isNotEmpty) url += "&title=" + vm.title;
      if (vm.user != null && vm.user != null) {
        url += "&recipient=" + vm.user.userId.toString();
      }
      if (vm.text != null && vm.text.isNotEmpty) url += "&text=" + vm.text;
    }
    var result = await apiProvider.get(url);
    if (result.status != Status.ERROR) {
      messages = (result.data['data'] as List)
          .map((item) => Message.fromJson(item))
          .toList();
    }
    return messages;
  }
}

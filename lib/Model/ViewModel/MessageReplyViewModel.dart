import 'dart:convert';

class MessageReplyViewModel {
  int messageId;
  String text;

  MessageReplyViewModel({this.messageId, this.text});

  MessageReplyViewModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

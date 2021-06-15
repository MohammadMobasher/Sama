import 'dart:convert';

class MessageReplyViewModel {
  int messageId;
  String text;
  String attachPath;

  MessageReplyViewModel({this.messageId, this.text, this.attachPath});

  MessageReplyViewModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

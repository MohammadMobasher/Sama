import 'dart:convert';

class MessageForwardViewModel {
  int messageId;
  String text;
  List<int> recipients;
  List<int> ccRecipients;
  List<int> bccRecipients;
  String attachPath;

  MessageForwardViewModel(
      {this.messageId,
      this.text,
      this.recipients,
      this.ccRecipients,
      this.bccRecipients,
      this.attachPath});

  MessageForwardViewModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    recipients = json['recipients'].cast<int>();
    ccRecipients = json['cc_recipients'].cast<int>();
    bccRecipients = json['bcc_recipients'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    for (var i = 0; i < this.recipients.length; i++) {
      data['recipients[$i]'] = this.recipients[i].toString();
    }
    return data;
  }
}

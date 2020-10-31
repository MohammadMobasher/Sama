class MessageInsertViewModel {
  String title;
  String text;
  List<int> recipients;
  List<int> ccRecipients;
  List<int> bccRecipients;

  MessageInsertViewModel(
      {this.title,
      this.text,
      this.recipients,
      this.ccRecipients,
      this.bccRecipients});

  MessageInsertViewModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    recipients = json['recipients'].cast<int>();
    ccRecipients = json['cc_recipients'].cast<int>();
    bccRecipients = json['bcc_recipients'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['text'] = this.text;
    for (var i = 0; i < this.recipients.length; i++) {
      data['recipients[$i]'] = this.recipients[i].toString();
    }
    if (this.ccRecipients != null && this.ccRecipients.length > 0) {
      for (var i = 0; i < this.ccRecipients.length; i++) {
        data['cc_recipients[$i]'] = this.ccRecipients[i].toString();
      }
    }

    if (this.bccRecipients != null && this.bccRecipients.length > 0) {
      for (var i = 0; i < this.bccRecipients.length; i++) {
        data['bcc_recipients[$i]'] = this.bccRecipients[i].toString();
      }
    }
    //
    // data['bcc_recipients'] = this.bccRecipients;
    return data;
  }
}

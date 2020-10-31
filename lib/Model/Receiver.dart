import 'User.dart';

class Receiver {
  int receiverId;
  int mailId;
  int receiver;
  bool archive;
  bool bookmark;
  bool isSeen;
  bool isReplyed;
  bool isCopy;
  bool isSecretCopy;
  bool archiveSent;
  User user;

  Receiver(
      {this.receiverId,
      this.mailId,
      this.receiver,
      this.archive,
      this.bookmark,
      this.isSeen,
      this.isReplyed,
      this.isCopy,
      this.isSecretCopy,
      this.archiveSent,
      this.user});

  Receiver.fromJson(Map<String, dynamic> json) {
    receiverId = json['receiver_id'];
    mailId = json['mail_id'];
    receiver = json['receiver'];
    archive =
        json['archive'] != null ? (json['archive'] == 1 ? true : false) : false;
    bookmark = json['bookmark'] != null
        ? (json['bookmark'] == 1 ? true : false)
        : false;
    isSeen = json['isSeen'] == 1 ? true : false;
    isReplyed = json['isReplyed'] != null
        ? (json['isReplyed'] == 1 ? true : false)
        : false;
    isCopy = json['isCopy'] == 1 ? true : false;
    isSecretCopy = json['isSecretCopy'] == 1 ? true : false;
    archiveSent = json['archiveSent'] != null
        ? (json['archiveSent'] == 1 ? true : false)
        : false;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiver_id'] = this.receiverId;
    data['mail_id'] = this.mailId;
    data['receiver'] = this.receiver;
    data['archive'] = this.archive;
    data['bookmark'] = this.bookmark;
    data['isSeen'] = this.isSeen;
    data['isReplyed'] = this.isReplyed;
    data['isCopy'] = this.isCopy;
    data['isSecretCopy'] = this.isSecretCopy;
    data['archiveSent'] = this.archiveSent;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

import 'package:equatable/equatable.dart';
import 'package:sama/Model/Sender.dart';
import 'package:sama/Model/Attache.dart';

import 'Receiver.dart';

class Message extends Equatable {
  int mailId;
  String title;
  DateTime date;
  bool isSeen;
  Sender sender;
  List<Attache> mainAttach;
  String text;
  List<Receiver> receivers;
  List<Attache> attaches;

  Message(
      {this.mailId,
      this.title,
      this.date,
      this.isSeen,
      this.sender,
      this.mainAttach});

  Message.fromJson(Map<String, dynamic> json) {
    mailId = json['mail_id'];
    title = json['title'];
    // mainAttach = json["mainAttach"];
    if (json['mainAttach'] != null) {
      mainAttach = new List<Attache>();
      json['mainAttach'].forEach((v) {
        mainAttach.add(new Attache.fromJson(v));
      });
    }
    text = json['text'] != null ? json['text'] : "";
    date = DateTime.parse(json['date'].toString());
    isSeen =
        json["isSeen"] != null ? (json['isSeen'] == 1 ? true : false) : false;

    if (json['attaches'] != null) {
      attaches = new List<Attache>();
      json['attaches'].forEach((v) {
        attaches.add(new Attache.fromJson(v));
      });
    }

    if (json['receivers'] != null) {
      receivers = new List<Receiver>();
      json['receivers'].forEach((v) {
        receivers.add(new Receiver.fromJson(v));
      });
    }
    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail_id'] = this.mailId;
    data['title'] = this.title;
    data['date'] = this.date;
    data['isSeen'] = this.isSeen;
    if (this.receivers != null) {
      data['receivers'] = this.receivers.map((v) => v.toJson()).toList();
    }
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [mailId, title, date, sender];
}

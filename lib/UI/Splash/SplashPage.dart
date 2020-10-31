// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FlatButton(
          onPressed: () {
            // AwesomeNotifications().createNotification(
            //     content: NotificationContent(
            //         id: 10,
            //         channelKey: 'basic_channel',
            //         title: 'پیام جدید',
            //         body: 'شما 8 پیام جدید دارید.'));
          },
          child: Text("mohammad")),
    ));
  }
}

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class Downloader {
  final Dio _dio = Dio();
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     new FlutterLocalNotificationsPlugin();
  BuildContext context1;

  Future<void> download(String url, BuildContext context) async {
    this.context1 = context;
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    // final iOS = IOSInitializationSettings();
    // final initSettings = InitializationSettings(android, iOS);

    // flutterLocalNotificationsPlugin.initialize(initSettings,
    //     onSelectNotification: _onSelectNotification);

    final dir = await getTemporaryDirectory();
    String fileName = path.basename(url);
    String savePath = path.join(dir.path, fileName);

    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response = await _dio.download(url, savePath,
          onReceiveProgress: _onReceiveProgress);
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (ex) {
      result['error'] = ex.toString();
    } finally {
      final isSuccess = result['isSuccess'];
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: 12,
        payload: {
          "uri": result['filePath'],
          "isSuccess": isSuccess ? "1" : "0"
        },
        channelKey: 'open_file_channel',
        title: isSuccess ? 'موفق' : 'خطا',
        body: isSuccess
            ? 'دانلود فایل با موفقیت انجام شد. برای مشاهده کلیک کنید'
            : 'دانلود فایل با خطا مجوتح شده است.',
      ));
    }
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {}
  }

  // Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
  //   final android = AndroidNotificationDetails(
  //       'channel id', 'channel name', 'channel description',
  //       priority: Priority.High, importance: Importance.Max);
  //   final iOS = IOSNotificationDetails();
  //   final platform = NotificationDetails(android, iOS);
  //   final json = jsonEncode(downloadStatus);
  //   final isSuccess = downloadStatus['isSuccess'];

  //   await flutterLocalNotificationsPlugin.show(
  //       0, // notification id
  //       isSuccess ? 'موفق' : 'خطا',
  //       isSuccess
  //           ? 'دانلود فایل با موفقیت انجام شد. برای مشاهده کلیک کنید'
  //           : 'دانلود فایل با خطا مجوتح شده است.',
  //       platform,
  //       payload: json);
  // }

  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: this.context1,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }
}

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:funflutter/utils/received_notif.dart';
import 'dart:math';

final selectNotificationSubject = BehaviorSubject<String?>();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static const _channelId = "01";
  static const _channelName = "channel_01";
  static const _channelDesc = "dicoding channel";
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }
  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  // Kita akan membuat beberapa fungsi jenis notifikasi di dalam kelas ini
  void configureDidReceiveLocalNotificationSubject(
      BuildContext context, String route) {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(receivedNotification.title ?? 'Notification Title'),
          content: Text(receivedNotification.body ?? 'Notification Body'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.pushNamed(context, route,
                    arguments: receivedNotification);
              },
            )
          ],
        ),
      );
    });
  }

  void requestIOSPermissions(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      },
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    });
  }

  /// TODO: Check below new Function
  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Hello There!',
      'Are you alright?',
      platformChannelSpecifics,
      payload: 'Payload notification',
    );
  }

  Future<void> showNotificationWithNoBody(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'plain title',
      null,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<void> scheduleNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var dateTime = DateTime.now().add(Duration(seconds: 5));
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      icon: 'secondary_icon',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      largeIcon: DrawableResourceAndroidBitmap('sample_large_icon'),
      vibrationPattern: vibrationPattern,
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
    );

    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // TODO: this may have problems with different time zones
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'scheduled title',
      'scheduled body',
      dateTime,
      platformChannelSpecifics,
      payload: 'scheduled notification',
    );
  }

  Future<void> showGroupedNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    // var groupKey = 'com.android.example.WORK_EMAIL';

    // TODO: This should not be same (need to hash/sth)
    var rng = new Random();
    var groupKey = rng.nextInt(100).toString();

    var firstNotificationAndroidSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      groupKey: groupKey,
    );

    var firstiOSPlatformChannelSpecifics =
        IOSNotificationDetails(threadIdentifier: groupKey);

    var firstNotificationPlatformSpecifics = NotificationDetails(
      android: firstNotificationAndroidSpecifics,
      iOS: firstiOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      1,
      'Alex Faarborg',
      'You will not believe...',
      firstNotificationPlatformSpecifics,
    );

    var secondNotificationAndroidSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      groupKey: groupKey,
    );

    var secondiOSPlatformChannelSpecifics =
        IOSNotificationDetails(threadIdentifier: groupKey);

    var secondNotificationPlatformSpecifics = NotificationDetails(
      android: secondNotificationAndroidSpecifics,
      iOS: secondiOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      2,
      'Jeff Chang',
      'Please join us to celebrate the...',
      secondNotificationPlatformSpecifics,
    );

    var lines = <String>[];
    lines.add('Alex Faarborg  Check this out');
    lines.add('Jeff Chang    Launch Party');

    var inboxStyleInformation = InboxStyleInformation(
      lines,
      contentTitle: '2 messages',
      summaryText: 'janedoe@example.com',
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      styleInformation: inboxStyleInformation,
      groupKey: groupKey,
      setAsGroupSummary: true,
    );

    var iosPlatformChannelSpecifics =
        IOSNotificationDetails(threadIdentifier: groupKey);

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      3,
      'Attention',
      '$groupKey = Key',
      platformChannelSpecifics,
    );
  }

  Future<void> showProgressNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var maxProgress = 5;
    for (var i = 0; i <= maxProgress; i++) {
      await Future.delayed(Duration(seconds: 1), () async {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          channelShowBadge: false,
          importance: Importance.max,
          priority: Priority.high,
          onlyAlertOnce: true,
          showProgress: true,
          maxProgress: maxProgress,
          progress: i,
        );

        var platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.show(
          0,
          'progress notification title',
          'progress notification body',
          platformChannelSpecifics,
          payload: 'item x',
        );
      });
    }
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> showBigPictureNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var largeIconPath = await _downloadAndSaveFile(
        'http://via.placeholder.com/48x48', 'largeIcon');
    var bigPicturePath = await _downloadAndSaveFile(
        'http://via.placeholder.com/400x800', 'bigPicture');

    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      contentTitle: 'overridden <b>big</b> content title',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true,
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      styleInformation: bigPictureStyleInformation,
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'big text title',
      'silent body',
      platformChannelSpecifics,
    );
  }

  Future<void> showNotificationWithAttachment(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var bigPicturePath = await _downloadAndSaveFile(
        'http://via.placeholder.com/600x200', 'bigPicture.jpg');
    print(bigPicturePath);
    var bigPictureAndroidStyle =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureAndroidStyle,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        attachments: [IOSNotificationAttachment(bigPicturePath)]);

    var notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'notification with attachment title',
      'notification with attachment body',
      notificationDetails,
    );
  }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificationSubject.stream.listen((String? payload) async {
      await Navigator.pushNamed(context, route,
          arguments: ReceivedNotification(payload: payload));
    });
  }
}

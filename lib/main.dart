import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:funflutter/ui/home_page.dart';
import 'package:funflutter/utils/notification_helper.dart';
import 'package:funflutter/ui/detail_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  /// Make sure that all of process is worked, because
  /// main file will run two process, which is permission
  /// and initiation from notification.
  WidgetsFlutterBinding.ensureInitialized();

  /// Call init notification function
  final NotificationHelper _notificationHelper = NotificationHelper();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  _notificationHelper.requestIOSPermissions(flutterLocalNotificationsPlugin);

  runApp(
    MaterialApp(
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        DetailPage.routeName: (context) => DetailPage(),
      },
    ),
  );
}

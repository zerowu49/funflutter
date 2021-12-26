import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:funflutter/common/navigation.dart';
import 'package:funflutter/data/api/api_service.dart';
import 'package:funflutter/data/preferences/preferences_helper.dart';
import 'package:funflutter/provider/news_provider.dart';
import 'package:funflutter/provider/preferences_provider.dart';
import 'package:funflutter/provider/scheduling_provider.dart';
import 'package:funflutter/ui/article_web_view.dart';
import 'package:funflutter/ui/home_page.dart';
import 'package:funflutter/data/model/article.dart';
import 'package:funflutter/ui/article_detail_page.dart';
import 'package:funflutter/utils/background_service.dart';
import 'package:funflutter/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (_, provider, __) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'News App',
            theme: provider.themeData,
            initialRoute: HomePage.routeName,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            routes: {
              HomePage.routeName: (context) => HomePage(),
              ArticleDetailPage.routeName: (context) => ArticleDetailPage(
                    article:
                        ModalRoute.of(context)?.settings.arguments as Article,
                  ),
              ArticleWebView.routeName: (context) => ArticleWebView(
                    url: ModalRoute.of(context)?.settings.arguments as String,
                  ),
            },
          );
        },
      ),
    );
  }
}

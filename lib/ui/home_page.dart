import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:funflutter/utils/background_service.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BackgroundService _service = BackgroundService();

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text(
                'Alarm with Delayed (Once)',
              ),
              onPressed: () async {
                print("==oneshot pressed==");
                await AndroidAlarmManager.oneShot(
                  Duration(seconds: 5),
                  1,
                  BackgroundService.callback,
                  exact: true,
                  wakeup: true,
                );
                print("==oneshot done==");
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                'Alarm with Date Time (Once)',
              ),
              onPressed: () async {
                print("==oneShotAt pressed==");

                await AndroidAlarmManager.oneShotAt(
                  DateTime.now().add(Duration(seconds: 5)),
                  2,
                  BackgroundService.callback,
                  exact: true,
                  wakeup: true,
                );
                print("==oneShotAt done==");
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                'Alarm with Periodic',
              ),
              onPressed: () async {
                print("==periodic pressed==");

                await AndroidAlarmManager.periodic(
                  Duration(seconds: 3),
                  3,
                  BackgroundService.callback,
                  startAt: DateTime.now(),
                  exact: true,
                  wakeup: true,
                );
                print("==periodic done==");
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                'Cancel Alarm by Id',
              ),
              onPressed: () async {
                print("==canceled pressed==");

                await AndroidAlarmManager.cancel(3);
                print("==canceled done==");
              },
            ),
          ],
        ),
      ),
    );
  }
}

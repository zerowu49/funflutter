import 'package:flutter/material.dart';
import 'package:funflutter/utils/received_notif.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  @override
  Widget build(BuildContext context) {
    final ReceivedNotification arg =
        ModalRoute.of(context)?.settings.arguments as ReceivedNotification;
    return Scaffold(
      appBar: AppBar(
        title: Text('Title: ${arg.payload}'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

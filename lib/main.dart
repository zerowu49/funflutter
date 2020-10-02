import 'package:dicoding_chatting/pages/chat_page.dart';
import 'package:dicoding_chatting/pages/login_page.dart';
import 'package:dicoding_chatting/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicoding Chatting',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(),
      },
    );
  }
}

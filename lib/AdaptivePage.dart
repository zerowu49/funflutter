import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funflutter/BuilderPage.dart';
import 'package:funflutter/SettingPage.dart';

class AdaptivePage extends StatefulWidget {
  @override
  _AdaptivePageState createState() => _AdaptivePageState();
}

class _AdaptivePageState extends State<AdaptivePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.news),
            title: Text('Feeds'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return BuilderPage(
              text: "Feeds Page",
            );
          case 1:
            return BuilderPage(
              text: "Search Page",
            );
          case 2:
            return SettingsPage();
          default:
            return Center(child: Text('Page not found!'));
        }
      },
    );
  }
}

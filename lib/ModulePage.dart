import 'package:flutter/material.dart';
import 'package:funflutter/DoneModuleList.dart';
import 'package:funflutter/ModuleList.dart';

class ModulePage extends StatefulWidget {
  @override
  _ModulePageState createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final List<String> doneModuleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memulai Pemrograman Dengan Dart'),
        actions: <Widget>[
          IconButton(
            key: Key('done_page_button'),
            icon: Icon(Icons.done),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoneModuleList(),
                ),
              );
            },
          ),
        ],
      ),
      body: ModuleList(doneModuleList: doneModuleList),
    );
  }
}

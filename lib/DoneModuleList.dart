import 'package:flutter/material.dart';

class DoneModuleList extends StatelessWidget {
  final List<String> doneModuleList;
  DoneModuleList({required this.doneModuleList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Done Module List'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(doneModuleList[index]),
          );
        },
        itemCount: doneModuleList.length,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:funflutter/LearningPathList.dart';

class LearningPathPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dicoding Learning Paths'),
      ),
      body: LearningPathList(),
    );
  }
}

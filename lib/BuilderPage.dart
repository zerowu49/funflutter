import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuilderPage extends StatelessWidget {
  final String text;

  BuilderPage({
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(text),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              text,
              style:
                  CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
            ),
            SizedBox(height: 100),
            CupertinoButton.filled(
              child: Text('Select Category'),
              onPressed: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return CupertinoActionSheet(
                        title: Text('Select Categories'),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      BuilderPage(text: 'Technology'),
                                ),
                              );
                            },
                            child: Text('Technology'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      BuilderPage(text: 'Business'),
                                ),
                              );
                            },
                            child: Text('Business'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      BuilderPage(text: 'Sport'),
                                ),
                              );
                            },
                            child: Text('Sport'),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: Text('Close'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

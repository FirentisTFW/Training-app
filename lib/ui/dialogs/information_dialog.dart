import 'package:flutter/material.dart';

class InformationDialogs {
  static Future showInformationDialog(BuildContext context,
      {String title, String message}) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () => Navigator.of(ctx).pop(),
          )
        ],
      ),
    );
  }
}

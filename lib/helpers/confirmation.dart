import 'package:flutter/material.dart';

class Confirmation {
  static Future<bool> confirmationDialog(BuildContext context) async {
    var isConfirmed = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            FlatButton(
              child: const Text("DELETE"),
              onPressed: () {
                isConfirmed = true;
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text("CANCEL"),
              onPressed: () {
                isConfirmed = false;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return isConfirmed;
  }

  static void displayMessage(String message, BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

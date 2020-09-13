import 'package:flutter/material.dart';

class ClientProfileListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function tapHandler;

  const ClientProfileListItem(this.title, this.icon, this.tapHandler);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      onPressed: tapHandler,
    );
  }
}

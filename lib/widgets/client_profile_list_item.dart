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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            Icon(
              icon,
              size: 30,
            ),
            SizedBox(width: 30),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onPressed: tapHandler,
    );
  }
}

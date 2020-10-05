import 'package:flutter/material.dart';

class NoItemsAddedYetInformator extends StatelessWidget {
  final String text;

  const NoItemsAddedYetInformator(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 24),
      ),
    );
  }
}

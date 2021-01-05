import 'package:flutter/material.dart';

class ErrorInformator extends StatelessWidget {
  final String message;

  const ErrorInformator(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

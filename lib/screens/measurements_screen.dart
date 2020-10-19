import 'package:flutter/material.dart';

class MeasurementsScreen extends StatelessWidget {
  static const routeName = '/measurements';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('Measurements'),
      ),
    );
  }
}

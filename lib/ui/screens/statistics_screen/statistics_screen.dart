import 'package:flutter/material.dart';

import '../../../widgets/main_drawer.dart';

class StatisticsScreen extends StatelessWidget {
  static const routeName = '/statistics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      drawer: MainDrawer(),
      body: Container(
        child: Text('Statistics'),
      ),
    );
  }
}

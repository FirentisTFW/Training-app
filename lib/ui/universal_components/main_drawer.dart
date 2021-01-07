import 'package:flutter/material.dart';

import '../screens/statistics_screen/statistics_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Training App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _CustomListTile(
            'Clients',
            Icons.people,
            () => goToClientScreen(context),
          ),
          _CustomListTile(
            'Statistics',
            Icons.insert_chart,
            () => goToStatisticsScreen(context),
          ),
        ],
      ),
    );
  }

  Future goToClientScreen(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed('/');

  Future goToStatisticsScreen(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(StatisticsScreen.routeName);
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function tapHandler;

  const _CustomListTile(this.title, this.icon, this.tapHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(
          icon,
          size: 28,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: tapHandler,
      ),
    );
  }
}

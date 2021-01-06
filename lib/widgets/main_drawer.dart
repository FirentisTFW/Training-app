import 'package:flutter/material.dart';

import '../ui/screens/statistics_screen/statistics_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
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
          buildListTile('Clients', Icons.people, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Statistics', Icons.insert_chart, () {
            Navigator.of(context)
                .pushReplacementNamed(StatisticsScreen.routeName);
          }),
        ],
      ),
    );
  }
}

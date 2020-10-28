import 'package:flutter/material.dart';

class StatisticsBigFieldInteger extends StatelessWidget {
  final String title;
  final int value;

  StatisticsBigFieldInteger({
    @required this.title,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class StatisticsBigFieldDouble extends StatelessWidget {
  final String title;
  final double value;

  StatisticsBigFieldDouble({
    @required this.title,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

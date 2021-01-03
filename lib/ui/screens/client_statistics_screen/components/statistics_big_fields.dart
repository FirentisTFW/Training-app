import 'package:flutter/material.dart';

class StatisticsBigField extends StatelessWidget {
  final String title;
  final num value;

  StatisticsBigField({
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
            style: TextStyle(fontSize: 22),
          ),
          Text(
            value.runtimeType == double
                ? value.toStringAsFixed(2)
                : value.toString(),
            style: TextStyle(fontSize: 26),
          ),
          Divider(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class StatisticsSmallField extends StatelessWidget {
  final String title;
  final String date;

  StatisticsSmallField({
    @required this.title,
    @required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 16),
            child: Text(
              title,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            date,
            style: date != "No workouts completed yet"
                ? TextStyle(fontSize: 20)
                : TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

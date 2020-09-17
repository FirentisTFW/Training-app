import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkoutItem extends StatelessWidget {
  final String programName;
  final DateTime date;

  WorkoutItem(
    this.programName,
    this.date,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat.yMd().format(date),
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  programName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

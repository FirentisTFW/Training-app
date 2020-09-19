import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_app/screens/workout_details_screen.dart';

import '../models/workout.dart';

class WorkoutItem extends StatelessWidget {
  final Workout workout;

  WorkoutItem(
    this.workout,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          WorkoutDetailsScreen.routeName,
          arguments: workout,
        );
      },
      child: Container(
        height: 100,
        child: Card(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateFormat.yMd().format(workout.date),
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
                    workout.programName,
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
      ),
    );
  }
}

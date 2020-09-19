import 'package:flutter/material.dart';

import '../models/workout.dart';
import '../widgets/done_exercise_details.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  static const routeName = '/workout-details';
  // final Workout workout;

  // WorkoutDetailsScreen(this.workout);

  @override
  Widget build(BuildContext context) {
    final Workout workout = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: workout.exercises.length,
        itemBuilder: (ctx, index) =>
            DoneExerciseDetails(workout.exercises[index]),
      ),
    );
  }
}

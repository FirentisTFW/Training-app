import 'package:flutter/material.dart';
import 'package:training_app/screens/edit_workout_screen.dart';

import '../models/workout.dart';
import '../widgets/done_exercise_details.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  static const routeName = '/workout-details';

  @override
  Widget build(BuildContext context) {
    final Workout workout = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushReplacementNamed(
              EditWorkoutScreen.routeName,
              arguments: workout,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: workout.exercises.length,
        itemBuilder: (ctx, index) =>
            DoneExerciseDetails(workout.exercises[index]),
      ),
    );
  }
}

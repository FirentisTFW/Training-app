import 'package:flutter/material.dart';
import 'package:training_app/models/workout_program.dart';

import '../widgets/program_exercises_list.dart';

class EditWorkoutProgramScreen extends StatefulWidget {
  static const routeName = "/edit-workout-program";

  @override
  _EditWorkoutProgramScreenState createState() =>
      _EditWorkoutProgramScreenState();
}

class _EditWorkoutProgramScreenState extends State<EditWorkoutProgramScreen> {
  final GlobalKey<ProgramExercisesListState> _exercisesListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final WorkoutProgram workoutProgram =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add exercises'),
      ),
      body: ProgramExercisesList(
        key: _exercisesListKey,
        initialValues: workoutProgram,
      ),
      floatingActionButton: Container(
        child: Align(
          alignment: Alignment(1.05, 0.85),
          child: FloatingActionButton.extended(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).accentColor,
            ),
            label: Text(
              'New exercise',
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
            backgroundColor: Colors.grey[600],
            onPressed: () =>
                _exercisesListKey.currentState.addAnotherExercise(),
          ),
        ),
      ),
    );
  }
}

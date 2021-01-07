import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/workout_program.dart';
import 'package:training_app/providers/workout_programs.dart';
import 'package:training_app/services/program_creator.dart';

import '../../universal_components/program_exercises_list.dart';

class EditWorkoutProgramScreen extends StatefulWidget {
  static const routeName = "/edit-workout-program";

  @override
  _EditWorkoutProgramScreenState createState() =>
      _EditWorkoutProgramScreenState();
}

class _EditWorkoutProgramScreenState extends State<EditWorkoutProgramScreen> {
  final GlobalKey<ProgramExercisesListState> _exercisesListKey = GlobalKey();
  ProgramCreator _programCreator;

  @override
  void initState() {
    super.initState();

    _programCreator =
        ProgramCreator(Provider.of<WorkoutPrograms>(context, listen: false));
  }

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
        programCreator: _programCreator,
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
            onPressed: _addAnotherExercise,
          ),
        ),
      ),
    );
  }

  void _addAnotherExercise() =>
      _exercisesListKey.currentState.addAnotherExercise();
}

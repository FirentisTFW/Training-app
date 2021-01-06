import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/workout_program.dart';

import '../../../providers/workout_programs.dart';
import '../../../screens/edit_workout_program_screen.dart';
import 'components/exercise_item.dart';

class ProgramDetailsScreen extends StatelessWidget {
  static const routeName = '/program-exercises';

  @override
  Widget build(BuildContext context) {
    final programData =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final workoutProgramsProvider = Provider.of<WorkoutPrograms>(context);
    final workoutProgram = workoutProgramsProvider.findByProgramNameAndClientId(
      programData['name'],
      programData['clientId'],
    );
    final exercises = workoutProgram.exercises;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () =>
                goToEditWorkoutProgramScreen(context, workoutProgram),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (ctx, index) => ExerciseItem(
          name: exercises[index].name,
          sets: exercises[index].sets,
          repsMin: exercises[index].repsMin,
          repsMax: exercises[index].repsMax,
        ),
      ),
    );
  }

  Future goToEditWorkoutProgramScreen(
          BuildContext context, WorkoutProgram workoutProgram) =>
      Navigator.of(context).pushNamed(
        EditWorkoutProgramScreen.routeName,
        arguments: workoutProgram,
      );
}

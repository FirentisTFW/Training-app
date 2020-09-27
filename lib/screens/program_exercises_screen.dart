import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_programs.dart';
import '../widgets/exercise_item.dart';

class ProgramExercisesScreen extends StatelessWidget {
  static const routeName = '/program-exercises';

  @override
  Widget build(BuildContext context) {
    final programData =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final workoutProgramsData = Provider.of<WorkoutPrograms>(context);
    final workoutProgram = workoutProgramsData.findByProgramNameAndClientId(
      programData['name'],
      programData['clientId'],
    );
    final exercises = workoutProgram.exercises;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (ctx, index) {
          return ExerciseItem(
            name: exercises[index].name,
            sets: exercises[index].sets,
            repsMin: exercises[index].repsMin,
            repsMax: exercises[index].repsMax,
          );
        },
      ),
    );
  }
}

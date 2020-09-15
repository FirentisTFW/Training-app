import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_programs.dart';

class ProgramExercisesScreen extends StatelessWidget {
  static const routeName = '/program-exercises';

  @override
  Widget build(BuildContext context) {
    final workoutProgramsData = Provider.of<WorkoutPrograms>(context);
    final workoutProgram = workoutProgramsData.findByProgramName('PULL');
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
          return Container(
            child: Text("lalala"),
          );
        },
      ),
    );
  }
}

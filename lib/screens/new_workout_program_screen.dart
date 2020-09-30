import 'package:flutter/material.dart';

import '../widgets/program_exercises_list.dart';

class NewWorkoutProgramScreen extends StatelessWidget {
  static const routeName = '/new-workout-program';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Workout Program'),
      ),
      body: ProgramExercisesList(),
    );
  }
}

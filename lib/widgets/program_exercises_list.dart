import 'package:flutter/material.dart';

import '../widgets/program_exercise_item.dart';

class ProgramExercisesList extends StatefulWidget {
  @override
  _ProgramExercisesListState createState() => _ProgramExercisesListState();
}

class _ProgramExercisesListState extends State<ProgramExercisesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          ProgramExerciseItem(),
          ProgramExerciseItem(),
        ],
      ),
    );
  }
}

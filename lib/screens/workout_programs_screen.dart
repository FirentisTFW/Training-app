import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_programs.dart';
import '../widgets/workout_program_item.dart';

class WorkoutProgramsScreen extends StatelessWidget {
  static const routeName = '/workout-programs';

  @override
  Widget build(BuildContext context) {
    final workoutProgramsData = Provider.of<WorkoutPrograms>(context);
    final workoutPrograms = workoutProgramsData.findByClientId('0');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        itemCount: workoutPrograms.length,
        itemBuilder: (ctx, index) {
          return WorkoutProgramItem(
            name: workoutPrograms[index].name,
            exercisesNumber: 5,
            setsNumber: 15,
          );
        },
      ),
    );
  }
}

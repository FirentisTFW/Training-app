import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/workout_programs.dart';
import '../../../../screens/new_workout_screen.dart';

class WorkoutProgramChooser extends StatelessWidget {
  final String clientId;

  WorkoutProgramChooser(this.clientId);

  @override
  Widget build(BuildContext context) {
    final workoutProgramsProvider = Provider.of<WorkoutPrograms>(context);
    final workoutPrograms = workoutProgramsProvider.findByClientId(clientId);

    return Card(
      color: Colors.grey[200],
      elevation: 8.0,
      child: Container(
        height: 400,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Choose a Program: ',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            Container(
              height: 250,
              child: ListView(
                children: workoutPrograms
                    .map((program) => _ProgramTile(program.name, clientId))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgramTile extends StatelessWidget {
  final String programName;
  final String clientId;

  const _ProgramTile(this.programName, this.clientId);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToNewWorkoutScreen(context),
      child: Card(
        child: Container(
          height: 80,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              programName,
              style: TextStyle(fontSize: 26),
            ),
          ),
        ),
      ),
    );
  }

  Future goToNewWorkoutScreen(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(
        NewWorkoutScreen.routeName,
        arguments: {
          'programName': programName,
          'clientId': clientId,
        },
      );
}

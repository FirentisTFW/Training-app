import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_programs.dart';

class WorkoutProgramChooser extends StatelessWidget {
  Widget _buildProgramTile(String programName) {
    return Card(
      child: Container(
        height: 80,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            programName,
            style: TextStyle(
              fontSize: 26,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutProgramsData = Provider.of<WorkoutPrograms>(context);
    final workoutPrograms = workoutProgramsData.findByClientId('0');
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
              height: 300,
              child: ListView(
                  children: workoutPrograms
                      .map((program) => _buildProgramTile(program.name))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}

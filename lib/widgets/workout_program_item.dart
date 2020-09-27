import 'package:flutter/material.dart';
import 'package:training_app/screens/program_exercises_screen.dart';

class WorkoutProgramItem extends StatelessWidget {
  final String clientId;
  final String name;
  final int exercisesNumber;
  final int setsNumber;

  WorkoutProgramItem({
    this.clientId,
    this.name,
    this.exercisesNumber,
    this.setsNumber,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProgramExercisesScreen.routeName, arguments: {
          'name': name,
          'clientId': clientId,
        });
      },
      child: Container(
        height: 100,
        child: Card(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Exercises: ${exercisesNumber.toString()}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Sets: ${setsNumber.toString()}',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

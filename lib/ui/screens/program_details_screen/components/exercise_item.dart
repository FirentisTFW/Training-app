import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  final String name;
  final int sets;
  final int repsMin;
  final int repsMax;

  ExerciseItem({
    @required this.name,
    @required this.sets,
    @required this.repsMin,
    @required this.repsMax,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    'Sets: ${sets.toString()}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Reps: ${repsMin.toString()} - ${repsMax.toString()}',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

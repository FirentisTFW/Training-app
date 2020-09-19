import 'package:flutter/material.dart';

import '../models/workout.dart';

class DoneExerciseDetails extends StatelessWidget {
  final WorkoutExercise exerciseDetails;

  DoneExerciseDetails(this.exerciseDetails);

  String _getNumberOfSets() {
    if (exerciseDetails.sets.length == 1) {
      return exerciseDetails.sets.length.toString() + ' set';
    }
    return exerciseDetails.sets.length.toString() + ' sets';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            height: 40,
            child: Text(
              exerciseDetails.name,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            height: 28,
            child: Text(
              _getNumberOfSets(),
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
              ),
            ),
          ),
          Container(
            height: 24.0 * exerciseDetails.sets.length,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: ListView(
              children: exerciseDetails.sets
                  .map((singleSet) => Container(
                        height: 24,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Reps: ',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  singleSet.reps.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Weight: ',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  singleSet.weight.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

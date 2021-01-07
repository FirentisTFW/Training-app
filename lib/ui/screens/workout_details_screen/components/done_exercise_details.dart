import 'package:flutter/material.dart';

import '../../../../models/workout.dart';

class DoneExerciseDetails extends StatelessWidget {
  final WorkoutExercise exerciseDetails;

  DoneExerciseDetails(this.exerciseDetails);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _ExerciseOverview(
            name: exerciseDetails.name,
            setsStr: _getNumberOfSetsStr(),
          ),
          _SetsOverview(sets: exerciseDetails.sets),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  String _getNumberOfSetsStr() {
    if (exerciseDetails.sets.length == 1) {
      return exerciseDetails.sets.length.toString() + ' set';
    }
    return exerciseDetails.sets.length.toString() + ' sets';
  }
}

class _ExerciseOverview extends StatelessWidget {
  final String name;
  final String setsStr;

  const _ExerciseOverview({Key key, this.name, this.setsStr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10),
          height: 40,
          child: Text(
            name,
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
            setsStr,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}

class _SetsOverview extends StatelessWidget {
  final List<Set> sets;

  const _SetsOverview({Key key, this.sets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0 * sets.length,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListView(
        children: sets
            .map(
              (singleSet) => Container(
                height: 24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Reps: ',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        SizedBox(width: 10),
                        Text(
                          singleSet.reps.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Weight: ',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        SizedBox(width: 10),
                        Text(
                          singleSet.weight.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

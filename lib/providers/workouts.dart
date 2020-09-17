import 'package:flutter/material.dart';

import '../models/workout.dart';

class Workouts with ChangeNotifier {
  List<Workout> _workouts = [
    Workout(
      id: DateTime.now().toString(),
      clientId: '0',
      date: DateTime.now(),
      programName: 'PULL',
      exercises: [
        WorkoutExercise(
          'Muscle Ups',
          [
            Set(
              reps: 5,
              weight: 0,
            ),
            Set(
              reps: 4,
              weight: 0,
            ),
            Set(
              reps: 4,
              weight: 0,
            ),
          ],
        ),
        WorkoutExercise(
          'Pull Ups',
          [
            Set(
              reps: 12,
              weight: 0,
            ),
            Set(
              reps: 10,
              weight: 0,
            ),
            Set(
              reps: 9,
              weight: 0,
            ),
          ],
        ),
        WorkoutExercise(
          'Australian Pull Ups',
          [
            Set(
              reps: 15,
              weight: 0,
            ),
            Set(
              reps: 13,
              weight: 0,
            ),
            Set(
              reps: 13,
              weight: 0,
            ),
          ],
        ),
      ],
    ),
  ];

  List<Workout> findByClientId(String clientId) {
    return _workouts.where((workout) => workout.clientId == clientId).toList();
  }
}

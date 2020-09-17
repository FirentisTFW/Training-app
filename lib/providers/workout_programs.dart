import 'package:flutter/material.dart';

import '../models/workout_program.dart';
import '../models/exercise.dart';

class WorkoutPrograms with ChangeNotifier {
  List<WorkoutProgram> _workoutPrograms = [
    WorkoutProgram(
      clientId: '0',
      name: 'PULL',
      exercises: [
        Exercise(
          id: '1',
          name: 'Muscle ups',
          exerciseType: ExerciseType.ForRepetitions,
          sets: 3,
          repsMin: 4,
          repsMax: 7,
        ),
        Exercise(
          id: '2',
          name: 'Pull ups',
          exerciseType: ExerciseType.ForRepetitions,
          sets: 4,
          repsMin: 8,
          repsMax: 12,
        ),
        Exercise(
          id: '3',
          name: 'Australian Pull Ups',
          exerciseType: ExerciseType.ForRepetitions,
          sets: 3,
          repsMin: 12,
          repsMax: 15,
        ),
        Exercise(
          id: '5',
          name: 'Bicep Curls',
          exerciseType: ExerciseType.ForRepetitions,
          sets: 3,
          repsMin: 8,
          repsMax: 12,
        ),
        Exercise(
          id: '4',
          name: 'Trap Raises',
          exerciseType: ExerciseType.ForRepetitions,
          sets: 2,
          repsMin: 10,
          repsMax: 15,
        ),
      ],
    ),
    WorkoutProgram(
      clientId: '0',
      name: 'PUSH',
      exercises: [
        Exercise(
          id: '2',
          name: 'Muscle ups',
          exerciseType: ExerciseType.ForRepetitions,
          sets: 4,
          repsMin: 4,
          repsMax: 7,
        ),
      ],
    ),
  ];

  List<WorkoutProgram> findByClientId(String clientId) {
    return _workoutPrograms
        .where((program) => program.clientId == clientId)
        .toList();
  }

  WorkoutProgram findByProgramName(String programName) {
    return _workoutPrograms
        .firstWhere((program) => program.name == programName);
  }
}

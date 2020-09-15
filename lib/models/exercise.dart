import 'package:flutter/foundation.dart';

enum ExerciseType {
  ForRepetitions,
  ForTime,
}

class Exercise {
  final String id;
  final String name;
  final ExerciseType exerciseType;
  final int sets;
  final int repsMin; // or duration
  final int repsMax; // or duration

  Exercise({
    @required this.id,
    @required this.name,
    @required this.exerciseType,
    @required this.sets,
    @required this.repsMin,
    @required this.repsMax,
  });
}

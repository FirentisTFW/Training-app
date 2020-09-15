import 'package:flutter/foundation.dart';

import './exercise.dart';

class WorkoutProgram {
  final List<Exercise> exercises;
  final String clientId;
  final String name;

  WorkoutProgram({
    @required this.exercises,
    @required this.clientId,
    @required this.name,
  });
}

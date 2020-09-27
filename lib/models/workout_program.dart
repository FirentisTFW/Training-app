import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import './exercise.dart';

part 'workout_program.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkoutProgram {
  final String clientId;
  final String name;
  final List<Exercise> exercises;

  WorkoutProgram({
    @required this.clientId,
    @required this.name,
    @required this.exercises,
  });

  factory WorkoutProgram.fromJson(Map<String, dynamic> json) =>
      _$WorkoutProgramFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutProgramToJson(this);

  int calculateTotalNumberOfSets() {
    int total = 0;
    exercises.forEach((exercise) => total += exercise.sets);
    return total;
  }
}

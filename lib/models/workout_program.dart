import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import './exercise.dart';

part 'workout_program.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkoutProgram extends Equatable {
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

  WorkoutProgram copyWith({
    String clientId,
    String name,
    List<Exercise> exercises,
  }) {
    return WorkoutProgram(
      clientId: clientId ?? this.clientId,
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
    );
  }

  int calculateTotalNumberOfSets() {
    int total = 0;
    exercises.forEach((exercise) => total += exercise.sets);
    return total;
  }

  @override
  List<Object> get props => [clientId, name, exercises];
}

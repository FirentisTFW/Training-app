import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

enum ExerciseType {
  ForRepetitions,
  ForTime,
}

@JsonSerializable(explicitToJson: true)
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

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  Exercise copyWith({
    String id,
    String name,
    ExerciseType exerciseType,
    int sets,
    int repsMin,
    int repsMax,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      exerciseType: exerciseType ?? this.exerciseType,
      sets: sets ?? this.sets,
      repsMin: repsMin ?? this.repsMin,
      repsMax: repsMax ?? this.repsMax,
    );
  }
}

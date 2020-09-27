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
}

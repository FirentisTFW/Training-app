import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:training_app/models/exercise.dart';

part 'workout.g.dart';

@JsonSerializable(explicitToJson: true)
class Workout extends Equatable {
  final String id;
  final String clientId;
  final DateTime date;
  final String programName;
  final List<WorkoutExercise> exercises;

  Workout({
    @required this.id,
    @required this.clientId,
    @required this.date,
    @required this.programName,
    this.exercises,
  });

  Workout copyWith({
    String clientId,
    DateTime date,
    String programName,
    List<WorkoutExercise> exercises,
  }) {
    return Workout(
      id: this.id,
      clientId: clientId ?? this.clientId,
      date: date ?? this.date,
      programName: programName ?? this.programName,
      exercises: exercises ?? this.exercises,
    );
  }

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);

  @override
  String toString() {
    return 'Workout(id: $id, clientId: $clientId, date: $date, programName: $programName, exercises: $exercises)';
  }

  @override
  List<Object> get props => [id, clientId, date, programName, exercises];
}

@JsonSerializable(explicitToJson: true)
class WorkoutExercise extends Equatable {
  final String name;
  final List<Set> sets;

  WorkoutExercise({
    this.name,
    this.sets,
  });

  WorkoutExercise copyWith({
    int name,
    List<Set> sets,
  }) {
    return WorkoutExercise(
      name: name ?? this.name,
      sets: sets ?? this.sets,
    );
  }

  WorkoutExercise removeEmptySetsFromExercise() {
    var newSets = this.sets;
    newSets.removeWhere((singleSet) => singleSet.reps == 0);
    return copyWith(
      sets: newSets,
    );
  }

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) =>
      _$WorkoutExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutExerciseToJson(this);

  @override
  String toString() => 'WorkoutExercise(name: $name, sets: $sets)';

  @override
  List<Object> get props => [name, sets];
}

@JsonSerializable(explicitToJson: true)
class Set extends Equatable {
  final int reps;
  final int weight;
  final ExerciseType exerciseType;

  Set({
    this.reps,
    this.weight,
    this.exerciseType,
  });

  Set copyWith({
    int reps,
    int weight,
    ExerciseType exerciseType,
  }) {
    return Set(
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      exerciseType: exerciseType ?? this.exerciseType,
    );
  }

  factory Set.fromJson(Map<String, dynamic> json) => _$SetFromJson(json);

  Map<String, dynamic> toJson() => _$SetToJson(this);

  @override
  String toString() =>
      'Set(reps: $reps, weight: $weight, exerciseType: $exerciseType)';

  @override
  List<Object> get props => [reps, weight, exerciseType];
}

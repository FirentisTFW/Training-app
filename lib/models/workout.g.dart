// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return Workout(
    id: json['id'] as String,
    clientId: json['clientId'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    programName: json['programName'] as String,
    exercises: (json['exercises'] as List)
        ?.map((e) => e == null
            ? null
            : WorkoutExercise.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'date': instance.date?.toIso8601String(),
      'programName': instance.programName,
      'exercises': instance.exercises?.map((e) => e?.toJson())?.toList(),
    };

WorkoutExercise _$WorkoutExerciseFromJson(Map<String, dynamic> json) {
  return WorkoutExercise(
    name: json['name'] as String,
    sets: (json['sets'] as List)
        ?.map((e) => e == null ? null : Set.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WorkoutExerciseToJson(WorkoutExercise instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sets': instance.sets?.map((e) => e?.toJson())?.toList(),
    };

Set _$SetFromJson(Map<String, dynamic> json) {
  return Set(
    reps: json['reps'] as int,
    weight: json['weight'] as int,
  );
}

Map<String, dynamic> _$SetToJson(Set instance) => <String, dynamic>{
      'reps': instance.reps,
      'weight': instance.weight,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutProgram _$WorkoutProgramFromJson(Map<String, dynamic> json) {
  return WorkoutProgram(
    exercises: (json['exercises'] as List)
        ?.map((e) =>
            e == null ? null : Exercise.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    clientId: json['clientId'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$WorkoutProgramToJson(WorkoutProgram instance) =>
    <String, dynamic>{
      'exercises': instance.exercises?.map((e) => e?.toJson())?.toList(),
      'clientId': instance.clientId,
      'name': instance.name,
    };

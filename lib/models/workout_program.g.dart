// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutProgram _$WorkoutProgramFromJson(Map<String, dynamic> json) {
  return WorkoutProgram(
    clientId: json['clientId'] as String,
    name: json['name'] as String,
    exercises: (json['exercises'] as List)
        ?.map((e) =>
            e == null ? null : Exercise.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WorkoutProgramToJson(WorkoutProgram instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'name': instance.name,
      'exercises': instance.exercises?.map((e) => e?.toJson())?.toList(),
    };

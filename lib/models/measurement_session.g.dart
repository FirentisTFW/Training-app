// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementSession _$MeasurementSessionFromJson(Map<String, dynamic> json) {
  return MeasurementSession(
    id: json['id'] as String,
    clientId: json['clientId'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    measurements: (json['measurements'] as List)
        ?.map((e) =>
            e == null ? null : Measurement.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    bodyMeasurements: (json['bodyMeasurements'] as List)
        ?.map((e) => e == null
            ? null
            : BodyMeasurement.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MeasurementSessionToJson(MeasurementSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'date': instance.date?.toIso8601String(),
      'measurements': instance.measurements?.map((e) => e?.toJson())?.toList(),
      'bodyMeasurements':
          instance.bodyMeasurements?.map((e) => e?.toJson())?.toList(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyMeasurement _$BodyMeasurementFromJson(Map<String, dynamic> json) {
  return BodyMeasurement(
    value: (json['value'] as num)?.toDouble(),
    type: _$enumDecodeNullable(_$MeasurementTypeEnumMap, json['type']),
    bodypart: _$enumDecodeNullable(_$BodypartEnumMap, json['bodypart']),
  );
}

Map<String, dynamic> _$BodyMeasurementToJson(BodyMeasurement instance) =>
    <String, dynamic>{
      'value': instance.value,
      'type': _$MeasurementTypeEnumMap[instance.type],
      'bodypart': _$BodypartEnumMap[instance.bodypart],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$MeasurementTypeEnumMap = {
  MeasurementType.Weight: 'Weight',
  MeasurementType.Bodyfat: 'Bodyfat',
  MeasurementType.BodyMeasurement: 'BodyMeasurement',
};

const _$BodypartEnumMap = {
  Bodypart.Arm: 'Arm',
  Bodypart.Forearm: 'Forearm',
  Bodypart.Chest: 'Chest',
  Bodypart.Waist: 'Waist',
  Bodypart.Hips: 'Hips',
  Bodypart.Thigh: 'Thigh',
  Bodypart.Calf: 'Calf',
};

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'measurement.g.dart';

enum MeasurementType {
  Bodyweight,
  Bodyfat,
  BodyMeasurement,
}

@JsonSerializable()
class Measurement {
  final double value;
  final MeasurementType type;

  Measurement({
    @required this.value,
    @required this.type,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) =>
      _$MeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementToJson(this);

  @override
  String toString() => 'Measurement(value: $value, type: $type)';
}

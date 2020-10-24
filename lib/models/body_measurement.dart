import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import './measurement.dart';

part 'body_measurement.g.dart';

enum Bodypart {
  Arm,
  Forearm,
  Chest,
  Waist,
  Hips,
  Thigh,
  Calf,
}

@JsonSerializable()
class BodyMeasurement extends Measurement {
  final Bodypart bodypart;

  BodyMeasurement({
    @required double value,
    @required MeasurementType type,
    @required this.bodypart,
  }) : super(
          value: value,
          type: type,
        );

  factory BodyMeasurement.fromJson(Map<String, dynamic> json) =>
      _$BodyMeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$BodyMeasurementToJson(this);
}

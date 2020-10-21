import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:training_app/models/body_measurement.dart';

part 'measurement_session.g.dart';

@JsonSerializable(explicitToJson: true)
class MeasurementSession {
  final String id;
  final String clientId;
  final DateTime date;
  final List<dynamic> measurements;

  MeasurementSession({
    @required this.id,
    @required this.clientId,
    @required this.date,
    @required this.measurements,
  });

  factory MeasurementSession.fromJson(Map<String, dynamic> json) =>
      _$MeasurementSessionFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementSessionToJson(this);

  double getBodyweight() {
    return measurements.firstWhere(
        (measurement) => measurement['type'] == 'Bodyweight')['value'];
  }

  double getBodyfat() {
    return measurements
        .firstWhere((measurement) => measurement['type'] == 'Bodyfat')['value'];
  }

  List<BodyMeasurement> getBodyMeasurements() {
    final bodyMeasurementsMap = measurements
        .where((measurement) => measurement['type'] == 'BodyMeasurement')
        .toList();
    final bodyMeasurements = bodyMeasurementsMap
        .map((measurement) => BodyMeasurement.fromJson(measurement))
        .toList();
    return bodyMeasurements;
  }
}

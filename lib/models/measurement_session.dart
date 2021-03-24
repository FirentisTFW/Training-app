import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:training_app/models/body_measurement.dart';
import 'package:training_app/models/measurement.dart';

part 'measurement_session.g.dart';

@JsonSerializable(explicitToJson: true)
class MeasurementSession {
  final String id;
  final String clientId;
  final DateTime date;
  final List<Measurement> measurements;
  final List<BodyMeasurement> bodyMeasurements;

  MeasurementSession({
    @required this.id,
    @required this.clientId,
    @required this.date,
    @required this.measurements,
    @required this.bodyMeasurements,
  });

  factory MeasurementSession.fromJson(Map<String, dynamic> json) =>
      _$MeasurementSessionFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementSessionToJson(this);

  MeasurementSession copyWith({
    String id,
    String clientId,
    DateTime date,
    List<Measurement> measurements,
    List<BodyMeasurement> bodyMeasurements,
  }) {
    return MeasurementSession(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      date: date ?? this.date,
      measurements: measurements ?? this.measurements,
      bodyMeasurements: bodyMeasurements ?? this.bodyMeasurements,
    );
  }

  double getBodyweight() {
    final bodyweightMeasurement = measurements.firstWhere(
        (measurement) => measurement.type == MeasurementType.Bodyweight,
        orElse: () => null);
    return bodyweightMeasurement?.value ?? null;
  }

  double getBodyfat() {
    final bodyfatMeasurement = measurements.firstWhere(
        (measurement) => measurement.type == MeasurementType.Bodyfat,
        orElse: () => null);
    return bodyfatMeasurement?.value ?? null;
  }

  @override
  String toString() {
    return 'MeasurementSession(id: $id, clientId: $clientId, date: $date, measurements: $measurements, bodyMeasurements: $bodyMeasurements)';
  }
}

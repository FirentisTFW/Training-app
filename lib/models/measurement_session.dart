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
  final List<dynamic> measurements; // either Measurement or BodyMeasurement

  MeasurementSession({
    @required this.id,
    @required this.clientId,
    @required this.date,
    @required this.measurements,
  });

  MeasurementSession copyWith({
    String id,
    String clientId,
    DateTime date,
    List<dynamic> measurements,
  }) {
    return MeasurementSession(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      date: date ?? this.date,
      measurements: measurements ?? this.measurements,
    );
  }

  factory MeasurementSession.fromJson(Map<String, dynamic> json) =>
      _$MeasurementSessionFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementSessionToJson(this);

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

  List<BodyMeasurement> getBodyMeasurements() {
    final bodyMeasurementsOriginal = measurements
        .where((measurement) =>
            measurement.type == MeasurementType.BodyMeasurement)
        .toList();
    final bodyMeasurementsMap = bodyMeasurementsOriginal.map((e) => e.toJson());
    // I KNOW I JUST CONVERTED OBJECT TO JSON AND BACK BUT SHIT DOESN'T WORK ANY OTHER WAY
    final bodyMeasurementsFinal = bodyMeasurementsMap
        .map((measurement) => BodyMeasurement.fromJson(measurement))
        .toList();
    return bodyMeasurementsFinal;
  }

  static List<dynamic> convertBodyMeasurementsFromMap(
      List<dynamic> measurements) {
    var bodyMeasurements = measurements.map(
      (singleMeasurement) {
        if (singleMeasurement['type'] != 'BodyMeasurement') {
          return Measurement.fromJson(singleMeasurement);
        } else {
          return BodyMeasurement.fromJson(singleMeasurement);
        }
      },
    ).toList();
    return bodyMeasurements;
  }
}

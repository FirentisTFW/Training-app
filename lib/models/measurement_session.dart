import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

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
}

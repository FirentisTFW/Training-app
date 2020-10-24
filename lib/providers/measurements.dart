import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_app/database/storage_provider.dart';
import 'package:training_app/models/body_measurement.dart';
import 'package:training_app/models/measurement.dart';
import 'package:training_app/models/measurement_session.dart';

class Measurements with ChangeNotifier {
  final String _storageFileName = '/measurements.json';
  List<MeasurementSession> _measurements = [
    MeasurementSession(
      clientId: "2020-09-27 10:54:08.975614",
      date: DateTime.now(),
      id: DateTime.now().toString(),
      measurements: [
        Measurement(
          type: MeasurementType.Bodyfat,
          value: 20.5,
        ),
        Measurement(
          type: MeasurementType.Bodyfat,
          value: 19.7,
        ),
        Measurement(
          type: MeasurementType.Bodyweight,
          value: 82,
        ),
        BodyMeasurement(
          type: MeasurementType.BodyMeasurement,
          bodypart: Bodypart.Waist,
          value: 78,
        ),
      ],
    ),
    MeasurementSession(
      clientId: "2020-09-27 10:54:08.975614",
      date: DateTime(2020, 10, 14),
      id: DateTime.now().toString(),
      measurements: [
        Measurement(
          type: MeasurementType.Bodyfat,
          value: 20.5,
        ),
        Measurement(
          type: MeasurementType.Bodyfat,
          value: 19.7,
        ),
        Measurement(
          type: MeasurementType.Bodyweight,
          value: 82,
        ),
        BodyMeasurement(
          type: MeasurementType.BodyMeasurement,
          bodypart: Bodypart.Waist,
          value: 78,
        ),
        BodyMeasurement(
          type: MeasurementType.BodyMeasurement,
          bodypart: Bodypart.Waist,
          value: 78,
        ),
      ],
    ),
  ];

  List<MeasurementSession> get measurements {
    return [..._measurements];
  }

  List<MeasurementSession> findByClientId(String clientId) {
    return _measurements
        .where((singleSession) => singleSession.clientId == clientId)
        .toList();
  }

  void addMeasurementSession(MeasurementSession newSession) {
    _measurements.add(newSession);

    notifyListeners();
  }

  // STORAGE MANAGEMENT

  Future<File> get localFile async {
    final path = await StorageProvider.localPath;
    return File('$path/$_storageFileName');
  }

  void _convertMeasurementsFromMap() {
    for (int i = 0; i < _measurements.length; i++) {
      var innerMeasurementsMap = _measurements[i].measurements;
      var test = Measurement.fromJson(innerMeasurementsMap[0]);
      var innerMeasurements = innerMeasurementsMap.map(
        (singleMeasurement) {
          if (singleMeasurement['type'] != 'BodyMeasurement') {
            return Measurement.fromJson(singleMeasurement);
          } else {
            return BodyMeasurement.fromJson(singleMeasurement);
          }
        },
      ).toList();
      _measurements[i] =
          _measurements[i].copyWith(measurements: innerMeasurements);
      print(_measurements[i].measurements);
    }
  }

  Future<void> fetchMeasurements() async {
    try {
      final fileData = await readDataFromFile();
      final measurementsMap = jsonDecode(fileData) as List;
      _measurements = measurementsMap
          .map((measurementSession) =>
              MeasurementSession.fromJson(measurementSession))
          .toList();
      _convertMeasurementsFromMap();

      notifyListeners();
    } catch (error) {}
  }

  Future<void> writeToFile() async {
    final file = await localFile;
    final measurementsInJson = jsonEncode(_measurements);
    await file.writeAsString(measurementsInJson.toString());
    notifyListeners();
  }

  Future<String> readDataFromFile() async {
    try {
      final file = await localFile;
      String content = await file.readAsString();
      return content;
    } catch (error) {
      return "An error occured";
    }
  }
}

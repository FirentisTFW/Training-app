import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_app/models/measurement_session.dart';
import 'package:training_app/services/storage_service.dart';

class Measurements with ChangeNotifier {
  List<MeasurementSession> _measurements;

  List<MeasurementSession> get measurements => _measurements;

  List<MeasurementSession> findByClientId(String clientId) => _measurements
      .where((singleSession) => singleSession.clientId == clientId)
      .toList();

  void addMeasurementSession(MeasurementSession newSession) {
    _measurements.add(newSession);

    notifyListeners();
  }

  void deleteMeasurementSession(String sessionId) {
    _measurements.removeWhere((singleSession) => singleSession.id == sessionId);
  }

  // STORAGE MANAGEMENT

  Future<File> get localFile async {
    final path = await StorageService.localPath;
    return File('$path/${StorageService.measurementsFileName}');
  }

  Future<void> fetchMeasurements() async {
    final fileData = await readDataFromFile();
    final measurementsMap = jsonDecode(fileData) as List;
    _measurements = measurementsMap
        .map((measurementSession) =>
            MeasurementSession.fromJson(measurementSession))
        .toList();

    _convertMeasurementsFromMap();

    notifyListeners();
  }

  void _convertMeasurementsFromMap() {
    for (int i = 0; i < _measurements.length; i++) {
      final innerMeasurementsConverted =
          MeasurementSession.convertBodyMeasurementsFromMap(
              _measurements[i].measurements);
      _measurements[i] =
          _measurements[i].copyWith(measurements: innerMeasurementsConverted);
    }
  }

  Future<void> writeToFile() async {
    final file = await localFile;
    final measurementsInJson = jsonEncode(_measurements);
    await file.writeAsString(measurementsInJson.toString());

    notifyListeners();
  }

  Future<String> readDataFromFile() async {
    final file = await localFile;
    String content = await file.readAsString();
    return content;
  }
}

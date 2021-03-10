import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_app/models/measurement_session.dart';
import 'package:training_app/services/storage_service.dart';

class Measurements with ChangeNotifier {
  List<MeasurementSession> _measurements = [];

  List<MeasurementSession> get measurements => _measurements;

  List<MeasurementSession> findByClientId(String clientId) => _measurements
      .where((singleSession) => singleSession.clientId == clientId)
      .toList();

  void addMeasurementSession(MeasurementSession newSession) {
    if (!_measurements.any((element) => element.id == newSession.id)) {
      _measurements.add(newSession);
    }

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

    if (fileData != null) {
      final measurementsMap = jsonDecode(fileData) as List;
      _measurements = measurementsMap
          .map((measurementSession) =>
              MeasurementSession.fromJson(measurementSession))
          .toList();
    }

    notifyListeners();
  }

  Future<String> readDataFromFile() async {
    final file = await localFile;
    if (await file.exists()) {
      String content = await file.readAsString();
      return content;
    }
    return null;
  }

  Future<void> writeToFile() async {
    final file = await localFile;
    final measurementsInJson = jsonEncode(_measurements);
    await file.writeAsString(measurementsInJson.toString());

    notifyListeners();
  }
}

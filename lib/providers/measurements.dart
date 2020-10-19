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
            type: MeasurementType.Weight,
            value: 82,
          ),
          BodyMeasurement(
            type: MeasurementType.Weight,
            bodypart: Bodypart.Waist,
            value: 78,
          ),
        ])
  ];

  List<MeasurementSession> get measurements {
    return [..._measurements];
  }

  List<MeasurementSession> findByClientId(String clientId) {
    return _measurements
        .where((singleSession) => singleSession.clientId == clientId)
        .toList();
  }

  // STORAGE MANAGEMENT

  Future<File> get localFile async {
    final path = await StorageProvider.localPath;
    return File('$path/$_storageFileName');
  }

  Future<void> writeToFile() async {
    final file = await localFile;
    final clientsInJson = jsonEncode(_measurements);
    await file.writeAsString(clientsInJson.toString());
    notifyListeners();
  }

  Future<String> readDataFromFile() async {
    try {
      final file = await localFile;
      String content = await file.readAsString();
      return content;
    } catch (e) {
      return "An error occured";
    }
  }
}

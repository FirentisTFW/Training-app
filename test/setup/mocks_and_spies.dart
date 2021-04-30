import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_app/models/client.dart';
import 'package:training_app/providers/clients.dart';
import 'package:training_app/providers/measurements.dart';
import 'package:training_app/providers/workout_programs.dart';
import 'package:training_app/providers/workouts.dart';

class ClientsSpy extends Clients {
  final ClientsMock clientsMock;
  final bool mockGetClientById;

  ClientsSpy({@required this.clientsMock, this.mockGetClientById = true});

  @override
  void notifyListeners() {
    super.notifyListeners();
    clientsMock.notifyListeners();
  }

  @override
  Client getClientById(String id) => mockGetClientById
      ? clientsMock.getClientById(id)
      : super.getClientById(id);

  @override
  Future<String> readDataFromFile() async => clientsMock.readDataFromFile();
}

class ClientsMock extends Mock {
  Future<String> readDataFromFile();
  void notifyListeners();

  Client getClientById(String id);
}

class WorkoutProgramsSpy extends WorkoutPrograms {
  final WorkoutProgramsMock programsMock;

  WorkoutProgramsSpy(this.programsMock);

  @override
  Future<String> readDataFromFile() async => programsMock.readDataFromFile();
}

class WorkoutProgramsMock extends Mock {
  Future<String> readDataFromFile();
}

class MeasurementsSpy extends Measurements {
  final MeasurementsMock measurementsMock;

  MeasurementsSpy(this.measurementsMock);

  @override
  Future<String> readDataFromFile() async =>
      measurementsMock.readDataFromFile();
}

class MeasurementsMock extends Mock {
  Future<String> readDataFromFile();
}

class WorkoutsSpy extends Workouts {
  final WorkoutsMock workoutsMock;

  WorkoutsSpy(this.workoutsMock);

  @override
  DateTime getLastWorkoutDateByClientId(String clientId) =>
      workoutsMock.getLastWorkoutDateByClientId(clientId);

  @override
  Future<String> readDataFromFile() async => workoutsMock.readDataFromFile();
}

class WorkoutsMock extends Mock {
  Future<String> readDataFromFile();

  DateTime getLastWorkoutDateByClientId(String clientId);
}

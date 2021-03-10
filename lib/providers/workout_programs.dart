import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_app/services/storage_service.dart';

import '../models/workout_program.dart';
import '../models/exercise.dart';

class WorkoutPrograms with ChangeNotifier {
  List<WorkoutProgram> _workoutPrograms = [];

  List<WorkoutProgram> get workoutPrograms => _workoutPrograms;

  List<WorkoutProgram> findByClientId(String clientId) => _workoutPrograms
      .where((program) => program.clientId == clientId)
      .toList();

  WorkoutProgram findByProgramNameAndClientId(
          String programName, String clientId) =>
      _workoutPrograms.firstWhere((program) =>
          program.name == programName && program.clientId == clientId);

  int getTotalNumberOfWorkoutProgramsByClientId(String clientId) =>
      findByClientId(clientId).length;

  void addProgram(WorkoutProgram program) => _workoutPrograms.add(program);

  void updateProgram(
      String clientId, String name, List<Exercise> newExercises) {
    final programIndex = _workoutPrograms.indexWhere(
        (program) => program.clientId == clientId && program.name == name);
    _workoutPrograms[programIndex] = _workoutPrograms[programIndex].copyWith(
      exercises: newExercises,
    );
  }

  void deleteProgram({String clientId, String programName}) =>
      _workoutPrograms.removeWhere((program) =>
          program.clientId == clientId && program.name == programName);

// STORAGE MANAGEMENT

  Future<File> get localFile async {
    final path = await StorageService.localPath;

    return File('$path/${StorageService.workoutProgramsFileName}');
  }

  Future<void> fetchWorkoutPrograms() async {
    final fileData = await readDataFromFile();

    if (fileData != null) {
      final programsMap = jsonDecode(fileData) as List;
      _workoutPrograms = programsMap
          .map((program) => WorkoutProgram.fromJson(program))
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
    final programsInJson = jsonEncode(_workoutPrograms);
    await file.writeAsString(programsInJson.toString());
    notifyListeners();
  }
}

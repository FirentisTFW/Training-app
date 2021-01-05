import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_app/services/storage_service.dart';

import '../models/workout_program.dart';
import '../models/exercise.dart';

class WorkoutPrograms with ChangeNotifier {
  List<WorkoutProgram> _workoutPrograms = [];
  WorkoutProgram _programCurrentlyBeingCreated = WorkoutProgram(
    clientId: null,
    name: null,
    exercises: null,
  );
  List<Exercise> _exercisesCurrentlyBeingCreated = [];

  List<WorkoutProgram> get workoutPrograms {
    return _workoutPrograms;
  }

  List<WorkoutProgram> findByClientId(String clientId) {
    return _workoutPrograms
        .where((program) => program.clientId == clientId)
        .toList();
  }

  WorkoutProgram findByProgramNameAndClientId(
      String programName, String clientId) {
    return _workoutPrograms.firstWhere((program) =>
        program.name == programName && program.clientId == clientId);
  }

  int getTotalNumberOfWorkoutProgramsByClientId(String clientId) {
    return findByClientId(clientId).length;
  }

  void nameNewProgram({
    String clientId,
    String name,
  }) {
    _programCurrentlyBeingCreated = _programCurrentlyBeingCreated.copyWith(
      name: name,
      clientId: clientId,
    );
  }

  void addExerciseToNewProgram(Exercise newExercise) {
    _exercisesCurrentlyBeingCreated.add(newExercise);
  }

  void saveNewProgram() {
    _programCurrentlyBeingCreated = _programCurrentlyBeingCreated.copyWith(
      exercises: _exercisesCurrentlyBeingCreated,
    );
    _workoutPrograms.add(_programCurrentlyBeingCreated);
    _resetNewProgram();
    resetNewExercises();
  }

  void _resetNewProgram() {
    _programCurrentlyBeingCreated = WorkoutProgram(
      clientId: null,
      name: null,
      exercises: null,
    );
  }

  void resetNewExercises() {
    _exercisesCurrentlyBeingCreated = [];
  }

  void updateProgram({
    String clientId,
    String name,
  }) {
    final programIndex = _workoutPrograms.indexWhere(
        (program) => program.clientId == clientId && program.name == name);
    _workoutPrograms[programIndex] = _workoutPrograms[programIndex].copyWith(
      exercises: _exercisesCurrentlyBeingCreated,
    );
  }

  void deleteProgram({
    String clientId,
    String programName,
  }) {
    _workoutPrograms.removeWhere(
      (program) => program.clientId == clientId && program.name == programName,
    );
  }

// STORAGE MANAGEMENT

  Future<File> get localFile async {
    final path = await StorageService.localPath;
    return File('$path/${StorageService.workoutProgramsFileName}');
  }

  Future<void> fetchWorkoutPrograms() async {
    try {
      final fileData = await readDataFromFile();
      final programsMap = jsonDecode(fileData) as List;
      _workoutPrograms = programsMap
          .map((program) => WorkoutProgram.fromJson(program))
          .toList();

      notifyListeners();
    } catch (error) {}
  }

  Future<void> writeToFile() async {
    final file = await localFile;
    final programsInJson = jsonEncode(_workoutPrograms);
    await file.writeAsString(programsInJson.toString());
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

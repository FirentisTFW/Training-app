import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/workout_program.dart';
import '../models/exercise.dart';
import '../database/storage_provider.dart';

class WorkoutPrograms with ChangeNotifier {
  List<WorkoutProgram> _workoutPrograms = [
    // WorkoutProgram(
    //   clientId: '2020-09-27 10:54:08.975614',
    //   name: 'PULL',
    //   exercises: [
    //     Exercise(
    //       id: '1',
    //       name: 'Muscle ups',
    //       exerciseType: ExerciseType.ForRepetitions,
    //       sets: 3,
    //       repsMin: 4,
    //       repsMax: 7,
    //     ),
    //     Exercise(
    //       id: '2',
    //       name: 'Pull ups',
    //       exerciseType: ExerciseType.ForRepetitions,
    //       sets: 4,
    //       repsMin: 8,
    //       repsMax: 12,
    //     ),
    //     Exercise(
    //       id: '3',
    //       name: 'Australian Pull Ups',
    //       exerciseType: ExerciseType.ForRepetitions,
    //       sets: 3,
    //       repsMin: 12,
    //       repsMax: 15,
    //     ),
    //     Exercise(
    //       id: '5',
    //       name: 'Bicep Curls',
    //       exerciseType: ExerciseType.ForRepetitions,
    //       sets: 3,
    //       repsMin: 8,
    //       repsMax: 12,
    //     ),
    //     Exercise(
    //       id: '4',
    //       name: 'Trap Raises',
    //       exerciseType: ExerciseType.ForRepetitions,
    //       sets: 2,
    //       repsMin: 10,
    //       repsMax: 15,
    //     ),
    //   ],
    // ),
    // WorkoutProgram(
    //   clientId: '2020-09-27 10:54:08.975614',
    //   name: 'PUSH',
    //   exercises: [
    //     Exercise(
    //       id: '2',
    //       name: 'Muscle ups',
    //       exerciseType: ExerciseType.ForRepetitions,
    //       sets: 4,
    //       repsMin: 4,
    //       repsMax: 7,
    //     ),
    //   ],
    // ),
  ];
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
  }

  void _resetNewProgram() {
    _programCurrentlyBeingCreated = WorkoutProgram(
      clientId: null,
      name: null,
      exercises: null,
    );
    _exercisesCurrentlyBeingCreated = [];
  }

// STORAGE MANAGEMENT

  Future<File> get localFile async {
    final path = await StorageProvider.localPath;
    return File('$path/workout_programs.json');
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

  Future<File> writeToFile() async {
    final file = await localFile;
    final programsInJson = jsonEncode(_workoutPrograms);
    return file.writeAsString(programsInJson.toString());
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

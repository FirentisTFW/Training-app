import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../database/storage_provider.dart';
import '../models/workout.dart';

class Workouts with ChangeNotifier {
  List<Workout> _workouts = [
    // Workout(
    //   id: DateTime.now().toString(),
    //   clientId: '0',
    //   date: DateTime.now(),
    //   programName: 'PULL',
    //   exercises: [
    //     WorkoutExercise(
    //       'Muscle Ups',
    //       [
    //         Set(
    //           reps: 5,
    //           weight: 0,
    //         ),
    //         Set(
    //           reps: 4,
    //           weight: 0,
    //         ),
    //         // Set(
    //         //   reps: 4,
    //         //   weight: 0,
    //         // ),
    //       ],
    //     ),
    //     WorkoutExercise(
    //       'Pull Ups',
    //       [
    //         Set(
    //           reps: 12,
    //           weight: 0,
    //         ),
    //         // Set(
    //         //   reps: 10,
    //         //   weight: 0,
    //         // ),
    //         // Set(
    //         //   reps: 9,
    //         //   weight: 0,
    //         // ),
    //       ],
    //     ),
    //     WorkoutExercise(
    //       'Australian Pull Ups',
    //       [
    //         Set(
    //           reps: 15,
    //           weight: 0,
    //         ),
    //         Set(
    //           reps: 13,
    //           weight: 0,
    //         ),
    //         Set(
    //           reps: 13,
    //           weight: 0,
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
  ];
  Workout _workoutCurrentlyBeingCreated;
  List<WorkoutExercise> _exercisesCurrentlyBeingCreated = [];

  List<Workout> findByClientId(String clientId) {
    return _workouts.where((workout) => workout.clientId == clientId).toList();
  }

  void initializeNewWorkout({
    String clientId,
    DateTime date,
    String programName,
  }) {
    _workoutCurrentlyBeingCreated = Workout(
      id: DateTime.now().toString(),
      clientId: clientId,
      date: date,
      programName: programName,
    );
  }

  void addExerciseToNewWorkoutIfNotEmpty(WorkoutExercise exercise) {
    exercise = exercise.removeEmptySetsFromExercise();
    if (exercise.sets.isNotEmpty) {
      _exercisesCurrentlyBeingCreated.add(exercise);
    }
  }

  void saveNewWorkout() {
    if (_exercisesCurrentlyBeingCreated.isEmpty) {
      return;
    }
    _workoutCurrentlyBeingCreated = _workoutCurrentlyBeingCreated.copyWith(
      exercises: _exercisesCurrentlyBeingCreated,
    );
    _workouts.add(_workoutCurrentlyBeingCreated);
    _resetNewWorkout();
  }

  void _resetNewWorkout() {
    _workoutCurrentlyBeingCreated = null;
    _exercisesCurrentlyBeingCreated = [];
  }

  void updateExercisesInWorkout(String workoutId) {
    final workoutIndex =
        _workouts.indexWhere((workout) => workout.id == workoutId);
    _workouts[workoutIndex] = _workouts[workoutIndex]
        .copyWith(exercises: _exercisesCurrentlyBeingCreated);
    _resetNewWorkout();
  }

  void deleteWorkout(String workoutId) {
    _workouts.removeWhere((workout) => workout.id == workoutId);
  }

  // STORAGE MANAGEMENT

  Future<File> get localFile async {
    final path = await StorageProvider.localPath;
    return File('$path/workouts.json');
  }

  Future<void> fetchWorkouts() async {
    try {
      final fileData = await readDataFromFile();
      final workoutsMap = jsonDecode(fileData) as List;
      _workouts =
          workoutsMap.map((program) => Workout.fromJson(program)).toList();

      notifyListeners();
    } catch (error) {}
  }

  Future<void> writeToFile() async {
    final file = await localFile;
    final workoutsInJson = jsonEncode(_workouts);
    await file.writeAsString(workoutsInJson.toString());
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

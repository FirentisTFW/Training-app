import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_app/services/storage_service.dart';

import '../models/workout.dart';

class Workouts with ChangeNotifier {
  List<Workout> _workouts = [];

  List<Workout> findByClientId(String clientId) =>
      _workouts.where((workout) => workout.clientId == clientId).toList();

  Workout findById(String workoutId) =>
      _workouts.firstWhere((w) => w.id == workoutId);

  void addWorkout(Workout workout) => _workouts.add(workout);

  void updateWorkout(String workoutId, List<WorkoutExercise> exercises) {
    final workoutIndex = _workouts.indexWhere((w) => w.id == workoutId);
    _workouts[workoutIndex] =
        _workouts[workoutIndex].copyWith(exercises: exercises);
  }

  void deleteWorkout(String workoutId) =>
      _workouts.removeWhere((workout) => workout.id == workoutId);

  int getTotalNumberOfWorkoutsByClientId(String clientId) =>
      findByClientId(clientId).length;

  double getNumberOfWorkoutsPerWeekByClientId(String clientId) {
    DateTime firstWorkoutDate = getFirstWorkoutDateByClientId(clientId);
    DateTime currentDate = DateTime.now();
    double dateDifferenceInWeeks =
        firstWorkoutDate?.difference(currentDate)?.inDays?.toDouble()?.abs() ??
            0.0;
    if (dateDifferenceInWeeks == 0.0) {
      // there's only one workout or all of the workouts were done the same day
      dateDifferenceInWeeks = 1;
    }
    return getTotalNumberOfWorkoutsByClientId(clientId) / dateDifferenceInWeeks;
  }

  DateTime getFirstWorkoutDateByClientId(String clientId) {
    final clientWorkouts = findByClientId(clientId);
    return clientWorkouts.isNotEmpty ? clientWorkouts.first.date : null;
  }

  DateTime getLastWorkoutDateByClientId(String clientId) {
    final clientWorkouts = findByClientId(clientId);
    return clientWorkouts.isNotEmpty ? clientWorkouts.last.date : null;
  }

  // STORAGE MANAGEMENT

  Future<File> get localFile async {
    final path = await StorageService.localPath;
    return File('$path/${StorageService.workoutsFileName}');
  }

  Future<void> fetchWorkouts() async {
    final fileData = await readDataFromFile();
    final workoutsMap = jsonDecode(fileData) as List;
    _workouts =
        workoutsMap.map((program) => Workout.fromJson(program)).toList();

    notifyListeners();
  }

  Future<String> readDataFromFile() async {
    final file = await localFile;
    String content = await file.readAsString();
    return content;
  }

  Future<void> writeToFile() async {
    final file = await localFile;
    final workoutsInJson = jsonEncode(_workouts);
    await file.writeAsString(workoutsInJson.toString());
    notifyListeners();
  }
}

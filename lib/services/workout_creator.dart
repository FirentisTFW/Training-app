import 'package:training_app/models/workout.dart';
import 'package:training_app/providers/workouts.dart';

class WorkoutCreator {
  final Workouts _workoutsProvider;
  Workout _workoutBeingCreated;
  List<WorkoutExercise> _exercisesBeingCreated = [];

  WorkoutCreator(this._workoutsProvider);

  void initialiseWorkout({String clientId, String programName, DateTime date}) {
    _workoutBeingCreated = Workout(
      id: DateTime.now().toString(),
      date: DateTime.now(),
      clientId: clientId,
      programName: programName,
      exercises: null,
    );
  }

  void addExercise(WorkoutExercise exercise) {
    exercise = exercise.removeEmptySetsFromExercise();
    if (exercise.sets.isNotEmpty) {
      _exercisesBeingCreated.add(exercise);
    }
  }

  Future saveWorkout() async {
    if (_exercisesBeingCreated.isEmpty) return;

    _workoutBeingCreated =
        _workoutBeingCreated.copyWith(exercises: _exercisesBeingCreated);

    _workoutsProvider.addWorkout(_workoutBeingCreated);

    try {
      await _workoutsProvider.writeToFile();
    } catch (err) {
      _workoutsProvider.deleteWorkout(_workoutBeingCreated.id);
      _exercisesBeingCreated = [];

      rethrow;
    }
  }

  Future updateWorkout(String workoutId) async {
    final originalExercises = _workoutsProvider.findById(workoutId).exercises;

    _workoutsProvider.updateWorkout(workoutId, _exercisesBeingCreated);

    try {
      await _workoutsProvider.writeToFile();
    } catch (err) {
      _workoutsProvider.updateWorkout(workoutId, originalExercises);
      _exercisesBeingCreated = [];

      rethrow;
    }
  }
}

import 'package:training_app/models/exercise.dart';
import 'package:training_app/models/workout_program.dart';
import 'package:training_app/providers/workout_programs.dart';

class ProgramCreator {
  final WorkoutPrograms _workoutProgramsProvider;
  WorkoutProgram _programBeingCreated;
  List<Exercise> _exercisesBeingCreated = [];

  ProgramCreator(this._workoutProgramsProvider);

  void initialiseProgram({String clientId, String name}) {
    _programBeingCreated =
        WorkoutProgram(clientId: clientId, name: name, exercises: null);
  }

  void addExercise(Exercise exercise) => _exercisesBeingCreated.add(exercise);

  Future saveProgram() async {
    _programBeingCreated =
        _programBeingCreated.copyWith(exercises: _exercisesBeingCreated);

    _workoutProgramsProvider.addProgram(_programBeingCreated);

    try {
      await _workoutProgramsProvider.writeToFile();
    } catch (err) {
      _workoutProgramsProvider.deleteProgram(
          clientId: _programBeingCreated.clientId,
          programName: _programBeingCreated.name);
      _exercisesBeingCreated = [];

      throw err;
    }
  }

  Future updateProgram(String clientId, String name) async {
    final originalExercises = _workoutProgramsProvider
        .findByProgramNameAndClientId(name, clientId)
        .exercises;

    _workoutProgramsProvider.updateProgram(
        clientId, name, _exercisesBeingCreated);

    try {
      await _workoutProgramsProvider.writeToFile();
    } catch (err) {
      _workoutProgramsProvider.updateProgram(clientId, name, originalExercises);
      _exercisesBeingCreated = [];

      throw err;
    }
  }
}

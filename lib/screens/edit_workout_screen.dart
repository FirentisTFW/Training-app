import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/workout.dart';
import '../providers/workouts.dart';
import '../providers/workout_programs.dart';
import '../ui/universal_components/exercise_and_sets.dart';

class EditWorkoutScreen extends StatefulWidget {
  static const routeName = '/edit-workout';

  @override
  _EditWorkoutScreenState createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
  List<GlobalKey<ExerciseAndSetsState>> _exercisesKeys = [];
  var _doneExercisesCurrentIndex = 0;
  var _maximalDoneExercisesIndex = 0;

  @override
  Widget build(BuildContext context) {
    final workout = ModalRoute.of(context).settings.arguments as Workout;
    final workoutProgramsProvider =
        Provider.of<WorkoutPrograms>(context, listen: false);
    final workoutProgram = workoutProgramsProvider.findByProgramNameAndClientId(
      workout.programName,
      workout.clientId,
    );

    _setMaximalDoneExercisesIndex(workout.exercises.length - 1);

    for (int i = 0; i < workoutProgram.exercises.length; i++) {
      setState(() {
        _exercisesKeys.add(GlobalKey());
      });
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveWorkout(context, workout.id),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < workoutProgram.exercises.length; i++)
                        ...{
                          _wasThisExerciseAlreadyDone(
                                  workoutProgram.exercises[i].name,
                                  workout
                                      .exercises[_doneExercisesCurrentIndex <=
                                              _maximalDoneExercisesIndex
                                          ? _doneExercisesCurrentIndex
                                          : _maximalDoneExercisesIndex]
                                      .name)
                              ? _buildFieldsWithInitialValues(
                                  keyIndex: i,
                                  exerciseName:
                                      workoutProgram.exercises[i].name,
                                  initialNumberOfSets: workout
                                      .exercises[_doneExercisesCurrentIndex - 1]
                                      .sets
                                      .length,
                                  initialSets: workout
                                      .exercises[_doneExercisesCurrentIndex - 1]
                                      .sets,
                                )
                              : _buildEmptyFields(
                                  keyIndex: i,
                                  exerciseName:
                                      workoutProgram.exercises[i].name,
                                  initialNumberOfSets:
                                      workoutProgram.exercises[i].sets,
                                )
                        }.toList(),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[600],
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 40,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () => _saveWorkout(context, workout.id),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyFields({
    int keyIndex,
    String exerciseName,
    int initialNumberOfSets,
  }) {
    return ExerciseAndSets(
      key: _exercisesKeys[keyIndex],
      exerciseName: exerciseName,
      initialNumberOfSets: initialNumberOfSets,
      initialSets: null,
    );
  }

  Widget _buildFieldsWithInitialValues({
    int keyIndex,
    String exerciseName,
    int initialNumberOfSets,
    List<Set> initialSets,
  }) {
    return ExerciseAndSets(
      key: _exercisesKeys[keyIndex],
      exerciseName: exerciseName,
      initialNumberOfSets: initialNumberOfSets,
      initialSets: initialSets,
    );
  }

  void _setMaximalDoneExercisesIndex(int maximalIndex) {
    setState(() {
      _maximalDoneExercisesIndex = maximalIndex;
    });
  }

  bool _wasThisExerciseAlreadyDone(
    String exerciseName,
    String firstUnmatchedDoneExerciseName,
  ) {
    if (exerciseName == firstUnmatchedDoneExerciseName) {
      _updateDoneExerciseIndex();
      return true;
    }
    return false;
  }

  void _updateDoneExerciseIndex() {
    if (_doneExercisesCurrentIndex <= _maximalDoneExercisesIndex) {
      setState(() {
        _doneExercisesCurrentIndex++;
      });
    }
  }

  Future<void> _saveWorkout(
    BuildContext context,
    String workoutId,
  ) async {
    if (!_tryToSaveExercises()) {
      return;
    }
    final workoutsProvider = Provider.of<Workouts>(context, listen: false);
    workoutsProvider.updateExercisesInWorkout(workoutId);
    await workoutsProvider.writeToFile();
    Navigator.of(context).pop();
  }

  bool _tryToSaveExercises() {
    var _areFormsValid = true;
    _exercisesKeys.forEach((element) {
      if (!element.currentState.saveForm()) {
        _areFormsValid = false;
      }
    });
    return _areFormsValid;
  }
}

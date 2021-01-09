import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/workout_program.dart';
import 'package:training_app/services/workout_creator.dart';
import 'package:training_app/ui/dialogs/information_dialog.dart';

import '../../../models/workout.dart';
import '../../../providers/workouts.dart';
import '../../../providers/workout_programs.dart';
import '../../universal_components/exercise_and_sets.dart';

class EditWorkoutScreen extends StatefulWidget {
  static const routeName = '/edit-workout';

  @override
  _EditWorkoutScreenState createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
  Workout workout;
  WorkoutProgram workoutProgram;
  WorkoutCreator _workoutCreator;
  List<GlobalKey<ExerciseAndSetsState>> _exercisesKeys = [];

  @override
  void initState() {
    super.initState();
    _workoutCreator =
        WorkoutCreator(Provider.of<Workouts>(context, listen: false));
  }

  @override
  Widget build(BuildContext context) {
    workout = ModalRoute.of(context).settings.arguments as Workout;
    workoutProgram = Provider.of<WorkoutPrograms>(context, listen: false)
        .findByProgramNameAndClientId(workout.programName, workout.clientId);

    _addGlobalKeys();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _updateWorkoutOrShowErrorInfo(workout.id),
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
                          _wasThisExerciseDoneInWorkout(
                                  workoutProgram.exercises[i].name)
                              ? _buildFieldsWithInitialValues(
                                  keyIndex: i,
                                  exerciseName:
                                      workoutProgram.exercises[i].name,
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
              _SaveButton(
                  onPressed: () => _updateWorkoutOrShowErrorInfo(workout.id)),
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
      workoutCreator: _workoutCreator,
      exerciseName: exerciseName,
      initialNumberOfSets: initialNumberOfSets,
      initialSets: null,
    );
  }

  Widget _buildFieldsWithInitialValues({
    int keyIndex,
    String exerciseName,
  }) {
    final initialSets =
        workout.exercises.firstWhere((ex) => ex.name == exerciseName).sets;
    return ExerciseAndSets(
      key: _exercisesKeys[keyIndex],
      workoutCreator: _workoutCreator,
      exerciseName: exerciseName,
      initialNumberOfSets: initialSets.length,
      initialSets: initialSets,
    );
  }

  void _addGlobalKeys() {
    for (int i = 0; i < workoutProgram.exercises.length; i++) {
      _exercisesKeys.add(GlobalKey());
    }
  }

  bool _wasThisExerciseDoneInWorkout(String exerciseName) =>
      workout.exercises.any((ex) => ex.name == exerciseName);

  Future<void> _updateWorkoutOrShowErrorInfo(String workoutId) async {
    if (_tryToSaveExercises()) {
      try {
        await _workoutCreator.updateWorkout(workoutId);
        Navigator.of(context).pop();
      } catch (err) {
        InformationDialogs.showInformationDialog(context,
            message: 'Couldn\'t update. Try again.', title: 'Try again');
      }
    }
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

class _SaveButton extends StatelessWidget {
  final Function onPressed;

  const _SaveButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 40,
        ),
        child: Text(
          'Update',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).accentColor,
          ),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: onPressed);
  }
}

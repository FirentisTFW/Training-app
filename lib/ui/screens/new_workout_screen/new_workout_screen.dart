import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/services/workout_creator.dart';
import 'package:training_app/ui/dialogs/information_dialog.dart';

import '../../../providers/workouts.dart';
import '../../../providers/workout_programs.dart';
import '../../universal_components/exercise_and_sets.dart';

// ignore: must_be_immutable
class NewWorkoutScreen extends StatelessWidget {
  static const routeName = '/new-workout';

  List<GlobalKey<ExerciseAndSetsState>> _exercisesKeys = [];
  WorkoutCreator _workoutCreator;

  @override
  Widget build(BuildContext context) {
    final programData =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final workoutProgramsProvider = Provider.of<WorkoutPrograms>(context);
    final program = workoutProgramsProvider.findByProgramNameAndClientId(
      programData['programName'],
      programData['clientId'],
    );

    _workoutCreator =
        WorkoutCreator(Provider.of<Workouts>(context, listen: false));

    for (int i = 0; i < program.exercises.length; i++) {
      _exercisesKeys.add(GlobalKey());
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => saveWorkout(context, programData),
          )
        ],
      ),
      body: Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < program.exercises.length; i++)
                          ...{
                            ExerciseAndSets(
                              key: _exercisesKeys[i],
                              workoutCreator: _workoutCreator,
                              exerciseName: program.exercises[i].name,
                              exerciseType: program.exercises[i].exerciseType,
                              initialNumberOfSets: program.exercises[i].sets,
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
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => saveWorkout(context, programData),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveWorkout(BuildContext context, var programData) async {
    if (saveExercises()) {
      _workoutCreator.initialiseWorkout(
        programName: programData['programName'],
        clientId: programData['clientId'],
        date: DateTime.now(),
      );

      try {
        await _workoutCreator.saveWorkout();
        Navigator.of(context).pop();
      } catch (err) {
        InformationDialogs.showSnackbar(
            'Couldn\'t add workout. Try again', context);
      }
    }
  }

  bool saveExercises() {
    var _areFormsValid = true;
    _exercisesKeys.forEach((element) {
      if (!element.currentState.saveForm()) {
        _areFormsValid = false;
      }
    });
    return _areFormsValid;
  }
}

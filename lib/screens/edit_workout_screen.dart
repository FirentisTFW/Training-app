import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/workout.dart';
import '../providers/workouts.dart';
import '../providers/workout_programs.dart';
import '../widgets/exercise_and_sets.dart';

class EditWorkoutScreen extends StatelessWidget {
  static const routeName = '/edit-workout';
  List<GlobalKey<ExerciseAndSetsState>> _exercisesKeys = [];

  @override
  Widget build(BuildContext context) {
    final workout = ModalRoute.of(context).settings.arguments as Workout;

    for (int i = 0; i < workout.exercises.length; i++) {
      _exercisesKeys.add(GlobalKey());
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => saveWorkout(context, workout.id),
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
                      for (int i = 0; i < workout.exercises.length; i++)
                        ...{
                          ExerciseAndSets(
                            key: _exercisesKeys[i],
                            exerciseName: workout.exercises[i].name,
                            initialNumberOfSets:
                                workout.exercises[i].sets.length,
                            initialSets: workout.exercises[i].sets,
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
                onPressed: () => saveWorkout(context, workout.id),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveWorkout(
    BuildContext context,
    String workoutId,
  ) async {
    if (!tryToSaveExercises()) {
      return;
    }
    final workoutsProvider = Provider.of<Workouts>(context, listen: false);
    workoutsProvider.updateExercisesInWorkout(workoutId);
    await workoutsProvider.writeToFile();
    Navigator.of(context).pop();
  }

  bool tryToSaveExercises() {
    var _areFormsValid = true;
    _exercisesKeys.forEach((element) {
      if (!element.currentState.saveForm()) {
        _areFormsValid = false;
      }
    });
    return _areFormsValid;
  }
}

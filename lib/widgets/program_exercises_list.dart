import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/workout_program.dart';
import '../widgets/program_exercise_item.dart';
import '../providers/workout_programs.dart';

class ProgramExercisesList extends StatefulWidget {
  final Key key;
  final WorkoutProgram initialValues;

  ProgramExercisesList({
    @required this.key,
    this.initialValues,
  });

  @override
  ProgramExercisesListState createState() => ProgramExercisesListState();
}

class ProgramExercisesListState extends State<ProgramExercisesList> {
  List<GlobalKey<ProgramExerciseItemState>> _exercisesKeys = [
    GlobalKey(),
  ];

  @override
  void initState() {
    super.initState();

    if (widget.initialValues != null) {
      _exercisesKeys = [];
      for (int i = 0; i < widget.initialValues.exercises.length; i++) {
        _exercisesKeys.add(GlobalKey());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("program-exercises-list");
    return Container(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < _exercisesKeys.length; i++)
                    ...{
                      ProgramExerciseItem(
                        key: _exercisesKeys[i],
                        removeExercise: removeExercise,
                        initialValues: widget.initialValues != null
                            ? widget.initialValues.exercises[i]
                            : null,
                      )
                    }.toList()
                ],
              ),
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            child: FlatButton(
              padding: EdgeInsets.all(12),
              child: Text(
                'Save Program',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20,
                ),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () => _saveProgram(),
            ),
          ),
        ],
      ),
    );
  }

  void removeExercise(Key exerciseKey) {
    setState(() {
      _exercisesKeys.removeWhere((singleKey) => singleKey == exerciseKey);
    });
  }

  void addAnotherExercise() {
    setState(() {
      _exercisesKeys.add(GlobalKey());
    });
  }

  Future<void> _saveProgram() async {
    if (widget.initialValues != null) {
      await _updateProgram();
      return;
    }

    final workoutProgramsProvider =
        Provider.of<WorkoutPrograms>(context, listen: false);
    if (!_tryToSaveExercises()) {
      workoutProgramsProvider.resetNewExercises();
      return;
    }
    workoutProgramsProvider.saveNewProgram();
    await workoutProgramsProvider.writeToFile();
    Navigator.of(context).pop();
  }

  Future<void> _updateProgram() async {
    final workoutProgramsProvider =
        Provider.of<WorkoutPrograms>(context, listen: false);
    workoutProgramsProvider.nameNewProgram(
      clientId: widget.initialValues.clientId,
      name: widget.initialValues.name,
    );
    if (!_tryToSaveExercises()) {
      workoutProgramsProvider.resetNewExercises();
      return;
    }
    workoutProgramsProvider.updateProgram(
      clientId: widget.initialValues.clientId,
      name: widget.initialValues.name,
    );
    await workoutProgramsProvider.writeToFile();
    workoutProgramsProvider.resetNewExercises();
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

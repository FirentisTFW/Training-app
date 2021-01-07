import 'package:flutter/material.dart';
import 'package:training_app/services/program_creator.dart';
import 'package:training_app/ui/dialogs/information_dialog.dart';

import '../../models/workout_program.dart';
import 'program_exercise_item.dart';

class ProgramExercisesList extends StatefulWidget {
  final Key key;
  final ProgramCreator programCreator;
  final WorkoutProgram initialValues;

  ProgramExercisesList(
      {@required this.key, @required this.programCreator, this.initialValues});

  @override
  ProgramExercisesListState createState() => ProgramExercisesListState();
}

class ProgramExercisesListState extends State<ProgramExercisesList> {
  List<GlobalKey<ProgramExerciseItemState>> _exercisesKeys = [GlobalKey()];

  @override
  void initState() {
    super.initState();
    _addExercisesIfProgramIsBeingEdited();
  }

  @override
  Widget build(BuildContext context) {
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
                        programCreator: widget.programCreator,
                        removeExercise: removeExercise,
                        initialValues: widget.initialValues != null &&
                                i < widget.initialValues.exercises.length
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
              onPressed: () async => _saveOrUpdateProgram(),
            ),
          ),
        ],
      ),
    );
  }

  void _addExercisesIfProgramIsBeingEdited() {
    if (widget.initialValues != null) {
      _exercisesKeys = [];
      for (int i = 0; i < widget.initialValues.exercises.length; i++) {
        _exercisesKeys.add(GlobalKey());
      }
    }
  }

  void removeExercise(Key exerciseKey) => setState(() =>
      _exercisesKeys.removeWhere((singleKey) => singleKey == exerciseKey));

  void addAnotherExercise() => setState(() => _exercisesKeys.add(GlobalKey()));

  Future<void> _saveOrUpdateProgram() async {
    if (widget.initialValues == null) {
      await _saveProgramOrShowErrorSnackbar();
    } else {
      await _updateProgramOrShowErrorSnackbar();
    }
  }

  Future<void> _saveProgramOrShowErrorSnackbar() async {
    if (_saveExercises()) {
      try {
        await widget.programCreator.saveProgram();
        Navigator.of(context).pop();
      } catch (err) {
        InformationDialogs.showSnackbar(
            'Couldn\'t add program. Try again', context);
      }
    }
  }

  Future<void> _updateProgramOrShowErrorSnackbar() async {
    if (_saveExercises()) {
      try {
        await widget.programCreator.updateProgram(
            widget.initialValues.clientId, widget.initialValues.name);
        Navigator.of(context).pop();
      } catch (err) {
        InformationDialogs.showSnackbar(
            'Couldn\'t update program. Try again', context);
      }
    }
  }

  bool _saveExercises() {
    var areFormsValid = true;
    _exercisesKeys.forEach((element) {
      if (!element.currentState.saveForm()) {
        areFormsValid = false;
      }
    });
    return areFormsValid;
  }
}

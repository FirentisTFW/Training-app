import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/validator.dart';
import '../models/exercise.dart';
import '../providers/workout_programs.dart';

class ProgramExerciseItem extends StatefulWidget {
  final key;

  ProgramExerciseItem({
    @required this.key,
  });

  @override
  ProgramExerciseItemState createState() => ProgramExerciseItemState();
}

class ProgramExerciseItemState extends State<ProgramExerciseItem> {
  final _newProgramForm = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();
  final _setsFocusNode = FocusNode();
  final _repsMinFocusNode = FocusNode();
  final _repsMaxFocusNode = FocusNode();
  var _isExerciseForReps = true;
  var _exercise = Exercise(
    id: DateTime.now().toString(),
    exerciseType: null,
    name: null,
    repsMax: null,
    repsMin: null,
    sets: null,
  );

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _typeFocusNode.dispose();
    _setsFocusNode.dispose();
    _repsMinFocusNode.dispose();
    _repsMaxFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("program-exercise-item-state");
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _newProgramForm,
              child: Column(
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Exercise Name'),
                    textInputAction: TextInputAction.next,
                    focusNode: _nameFocusNode,
                    keyboardType: TextInputType.name,
                    validator: (value) =>
                        Validator.validateForEmptyString(value),
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_typeFocusNode),
                    onSaved: (value) =>
                        _exercise = _exercise.copyWith(name: value),
                  ),
                  DropdownButtonFormField(
                    decoration:
                        const InputDecoration(labelText: 'Exercise Type'),
                    focusNode: _typeFocusNode,
                    value: ExerciseType.ForRepetitions,
                    items: [
                      DropdownMenuItem(
                        value: ExerciseType.ForRepetitions,
                        child: const Text('For Repetitions'),
                      ),
                      DropdownMenuItem(
                        value: ExerciseType.ForTime,
                        child: const Text('For Time'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        if (value == ExerciseType.ForRepetitions) {
                          _isExerciseForReps = true;
                        } else {
                          _isExerciseForReps = false;
                        }
                      });
                      FocusScope.of(context).requestFocus(_setsFocusNode);
                    },
                    onSaved: (value) =>
                        _exercise = _exercise.copyWith(exerciseType: value),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Sets'),
                    textInputAction: TextInputAction.next,
                    focusNode: _setsFocusNode,
                    keyboardType: TextInputType.number,
                    validator: (value) => Validator.validateForNumber(value),
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_repsMinFocusNode),
                    onSaved: (value) =>
                        _exercise = _exercise.copyWith(sets: int.parse(value)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText:
                          _isExerciseForReps ? 'Reps Min' : 'Seconds Min',
                    ),
                    textInputAction: TextInputAction.next,
                    focusNode: _repsMinFocusNode,
                    keyboardType: TextInputType.number,
                    validator: (value) => Validator.validateForNumber(value),
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_repsMaxFocusNode),
                    onSaved: (value) => _exercise =
                        _exercise.copyWith(repsMin: int.parse(value)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText:
                          _isExerciseForReps ? 'Reps Max' : 'Seconds Max',
                    ),
                    textInputAction: TextInputAction.next,
                    focusNode: _repsMaxFocusNode,
                    keyboardType: TextInputType.number,
                    validator: (value) => Validator.validateForNumber(value),
                    onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (value) => _exercise =
                        _exercise.copyWith(repsMax: int.parse(value)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveForm() {
    final isValid = _newProgramForm.currentState.validate();
    if (!isValid) {
      return;
    }
    _newProgramForm.currentState.save();
    final workoutProgramsProvider =
        Provider.of<WorkoutPrograms>(context, listen: false);
    workoutProgramsProvider.addExerciseToNewProgram(_exercise);
  }
}

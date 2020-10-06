import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/workout.dart';

import '../helpers/validator.dart';
import '../providers/workouts.dart';

class ExerciseAndSets extends StatefulWidget {
  final key;
  final String exerciseName;
  final int initialSets;

  ExerciseAndSets({
    this.key,
    this.exerciseName,
    this.initialSets,
  });

  @override
  ExerciseAndSetsState createState() => ExerciseAndSetsState();
}

class ExerciseAndSetsState extends State<ExerciseAndSets> {
  int _numberOfSets;
  List<FocusNode> _numberOfSetsFocusNodes = [];
  List<FocusNode> _weightFocusNodes = [];
  var _exerciseFormKey = GlobalKey<FormState>();
  WorkoutExercise _exercise;
  List<Set> _sets = [];

  @override
  void initState() {
    _numberOfSets = widget.initialSets;
    for (int i = 0; i < _numberOfSets; i++) {
      _addSet();
    }
    _exercise = WorkoutExercise(
      name: widget.exerciseName,
      sets: null,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Form(
        key: _exerciseFormKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.exerciseName,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            for (int i = 0; i < _numberOfSets; i++) ...{
              _buildInputField(i + 1),
            },
            SizedBox(height: 20),
            FlatButton(
              child: Text(
                'Add Another Set',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                _addAnotherSet();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          number.toString() + '. set',
          style: TextStyle(fontSize: 20),
        ),
        Container(
          width: 80,
          child: TextFormField(
              decoration: InputDecoration(
                hintText: 'reps',
                contentPadding: EdgeInsets.all(10),
              ),
              style: TextStyle(fontSize: 20),
              focusNode: _numberOfSetsFocusNodes[number - 1],
              keyboardType: TextInputType.number,
              validator: (value) => Validator.validateForNumber(value),
              onFieldSubmitted: (value) => FocusScope.of(context)
                  .requestFocus(_weightFocusNodes[number - 1]),
              onSaved: (value) {
                var x = value;
                if (x.isNotEmpty) {
                  _sets[number - 1] =
                      _sets[number - 1].copyWith(reps: int.parse(value));
                }
              }),
        ),
        Container(
          width: 80,
          child: TextFormField(
              decoration: InputDecoration(
                hintText: 'weight',
                contentPadding: EdgeInsets.all(10),
              ),
              style: TextStyle(fontSize: 20),
              focusNode: _weightFocusNodes[number - 1],
              keyboardType: TextInputType.number,
              validator: (value) => Validator.validateForNumber(value),
              onFieldSubmitted: (value) => FocusScope.of(context)
                  .requestFocus(_numberOfSetsFocusNodes[number]),
              onSaved: (value) {
                if (value.isNotEmpty) {
                  _sets[number - 1] =
                      _sets[number - 1].copyWith(weight: int.parse(value));
                }
              }),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _numberOfSetsFocusNodes.forEach(
      (element) => element.dispose(),
    );
    _weightFocusNodes.forEach(
      (element) => element.dispose(),
    );
    super.dispose();
  }

  void _addAnotherSet() {
    setState(() {
      _numberOfSets++;
      _addSet();
    });
  }

  void _addSet() {
    _numberOfSetsFocusNodes.add(FocusNode());
    _weightFocusNodes.add(FocusNode());
    _sets.add(
      Set(
        reps: 0,
        weight: 0,
      ),
    );
  }

  void saveForm() {
    final isValid = _exerciseFormKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _exerciseFormKey.currentState.save();
    _addSetsToExercise();
    final workoutsProvider = Provider.of<Workouts>(context, listen: false);
    workoutsProvider.addExerciseToNewWorkoutIfNotEmpty(_exercise);
  }

  void _addSetsToExercise() {
    _exercise = _exercise.copyWith(sets: [..._sets]);
  }
}

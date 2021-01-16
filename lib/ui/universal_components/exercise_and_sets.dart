import 'package:flutter/material.dart';
import 'package:training_app/models/workout.dart';
import 'package:training_app/services/workout_creator.dart';

import '../../services/validator.dart';

class ExerciseAndSets extends StatefulWidget {
  final Key key;
  final WorkoutCreator workoutCreator;
  final String exerciseName;
  final int initialNumberOfSets;
  final List<Set> initialSets;

  ExerciseAndSets({
    @required this.key,
    @required this.workoutCreator,
    @required this.exerciseName,
    @required this.initialNumberOfSets,
    this.initialSets,
  });

  @override
  ExerciseAndSetsState createState() => ExerciseAndSetsState();
}

class ExerciseAndSetsState extends State<ExerciseAndSets> {
  var _exerciseFormKey = GlobalKey<FormState>();
  int _numberOfSets;
  FocusNode _focusNode;

  WorkoutExercise _exercise;
  List<Set> _sets = [];

  @override
  void initState() {
    super.initState();
    _numberOfSets = widget.initialNumberOfSets;
    for (int i = 0; i < _numberOfSets; i++) {
      _addSet();
    }
    _exercise = WorkoutExercise(name: widget.exerciseName);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
                style: TextStyle(fontSize: 24),
              ),
            ),
            for (int i = 0; i < _numberOfSets; i++) ...{
              _buildInputField(
                  i + 1,
                  widget.initialSets != null
                      ? i < widget.initialSets.length
                          ? widget.initialSets[i]
                          : null
                      : null),
            },
            SizedBox(height: 20),
            FlatButton(
              child: Text(
                'Add Another Set',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: _addAnotherSet,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(int number, [Set initialValues]) {
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
              initialValue:
                  initialValues != null ? initialValues.reps.toString() : null,
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) => Validator.validateForNumber(value),
              onFieldSubmitted: (value) => _focusNode.nextFocus(),
              onSaved: (value) {
                if (value.isNotEmpty) {
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
              initialValue: initialValues != null
                  ? initialValues.weight.toString()
                  : null,
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) => Validator.validateForNumber(value),
              onFieldSubmitted: (value) => _focusNode.nextFocus(),
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

  void _addAnotherSet() => setState(() {
        _numberOfSets++;
        _addSet();
      });

  void _addSet() => _sets.add(
        Set(
          reps: 0,
          weight: 0,
        ),
      );

  bool saveForm() {
    final isValid = _exerciseFormKey.currentState.validate();
    if (isValid) {
      _exerciseFormKey.currentState.save();
      _addSetsToExercise();
      widget.workoutCreator.addExercise(_exercise);
      return true;
    }
    return false;
  }

  void _addSetsToExercise() => _exercise = _exercise.copyWith(sets: _sets);
}

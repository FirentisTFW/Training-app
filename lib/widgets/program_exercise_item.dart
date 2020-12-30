import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/ui/dialogs/confirmation.dart';

import '../services/validator.dart';
import '../models/exercise.dart';
import '../providers/workout_programs.dart';

class ProgramExerciseItem extends StatefulWidget {
  final Key key;
  final Function removeExercise;
  final Exercise initialValues;

  ProgramExerciseItem({
    @required this.key,
    @required this.removeExercise,
    this.initialValues,
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
                  Row(
                    children: [
                      Container(
                        width: 300,
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Exercise Name'),
                          initialValue: widget.initialValues != null
                              ? widget.initialValues.name
                              : null,
                          textInputAction: TextInputAction.next,
                          focusNode: _nameFocusNode,
                          keyboardType: TextInputType.name,
                          validator: (value) =>
                              Validator.validateForEmptyString(value),
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_typeFocusNode),
                          onSaved: (value) =>
                              _exercise = _exercise.copyWith(name: value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 26,
                          ),
                          onPressed: () => _confirmRemovingExercise(context),
                        ),
                      )
                    ],
                  ),
                  DropdownButtonFormField(
                    decoration:
                        const InputDecoration(labelText: 'Exercise Type'),
                    focusNode: _typeFocusNode,
                    value: widget.initialValues != null
                        ? widget.initialValues.exerciseType
                        : ExerciseType.ForRepetitions,
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
                    initialValue: widget.initialValues != null
                        ? widget.initialValues.sets.toString()
                        : null,
                    textInputAction: TextInputAction.next,
                    focusNode: _setsFocusNode,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validator.validateForEmptyAndNumber(value),
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
                    initialValue: widget.initialValues != null
                        ? widget.initialValues.repsMin.toString()
                        : null,
                    textInputAction: TextInputAction.next,
                    focusNode: _repsMinFocusNode,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validator.validateForEmptyAndNumber(value),
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
                    initialValue: widget.initialValues != null
                        ? widget.initialValues.repsMin.toString()
                        : null,
                    textInputAction: TextInputAction.next,
                    focusNode: _repsMaxFocusNode,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validator.validateForEmptyAndNumber(value),
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

  Future<void> _confirmRemovingExercise(BuildContext context) async {
    final isConfirmed = await Confirmation.confirmationDialog(context);

    if (isConfirmed) {
      widget.removeExercise(widget.key);
    }
  }

  bool saveForm() {
    final isValid = _newProgramForm.currentState.validate();
    if (!isValid) {
      return false;
    }
    _newProgramForm.currentState.save();
    final workoutProgramsProvider =
        Provider.of<WorkoutPrograms>(context, listen: false);
    workoutProgramsProvider.addExerciseToNewProgram(_exercise);
    return true;
  }
}

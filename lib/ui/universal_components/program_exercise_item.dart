import 'package:flutter/material.dart';
import 'package:training_app/services/program_creator.dart';
import 'package:training_app/ui/dialogs/confirmation.dart';

import '../../services/validator.dart';
import '../../models/exercise.dart';

class ProgramExerciseItem extends StatefulWidget {
  final Key key;
  final ProgramCreator programCreator;
  final Function removeExercise;
  final Exercise initialValues;

  ProgramExerciseItem({
    @required this.key,
    @required this.programCreator,
    @required this.removeExercise,
    this.initialValues,
  });

  @override
  ProgramExerciseItemState createState() => ProgramExerciseItemState();
}

class ProgramExerciseItemState extends State<ProgramExerciseItem> {
  final _newProgramForm = GlobalKey<FormState>();
  final _focusNode = FocusNode();
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
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Exercise Name'),
                            initialValue: widget.initialValues != null
                                ? widget.initialValues.name
                                : null,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            validator: (value) =>
                                Validator.validateForEmptyString(value),
                            onFieldSubmitted: (_) => _focusNode.nextFocus(),
                            onSaved: (value) =>
                                _exercise = _exercise.copyWith(name: value),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 26,
                            ),
                            onPressed: () => _confirmRemovingExercise(context),
                          ),
                        ),
                      )
                    ],
                  ),
                  DropdownButtonFormField(
                    decoration:
                        const InputDecoration(labelText: 'Exercise Type'),
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
                      _changeExerciseType(value);
                      _focusNode.nextFocus();
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
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validator.validateForEmptyAndNumber(value),
                    onFieldSubmitted: (_) => _focusNode.nextFocus(),
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
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validator.validateForEmptyAndNumber(value),
                    onFieldSubmitted: (_) => _focusNode.nextFocus(),
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

  void _changeExerciseType(ExerciseType value) => setState(() {
        if (value == ExerciseType.ForRepetitions) {
          _isExerciseForReps = true;
        } else {
          _isExerciseForReps = false;
        }
      });

  Future<void> _confirmRemovingExercise(BuildContext context) async {
    final isConfirmed = await Confirmation.confirmationDialog(context);

    if (isConfirmed) {
      widget.removeExercise(widget.key);
    }
  }

  bool saveForm() {
    final isValid = _newProgramForm.currentState.validate();

    if (isValid) {
      _newProgramForm.currentState.save();
      widget.programCreator.addExercise(_exercise);
      return true;
    }
    return false;
  }
}

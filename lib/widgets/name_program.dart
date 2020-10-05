import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/validator.dart';
import '../providers/workout_programs.dart';

class NameProgram extends StatefulWidget {
  final clientId;
  final Function nameWasGiven;

  NameProgram(
    this.clientId,
    this.nameWasGiven,
  );

  @override
  _NameProgramState createState() => _NameProgramState();
}

class _NameProgramState extends State<NameProgram> {
  final _nameFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _nameFormKey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name a program'),
                keyboardType: TextInputType.name,
                validator: (value) => Validator.validateForEmptyString(value),
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                onSaved: (value) => _saveName(value),
              ),
              SizedBox(height: 30),
              FlatButton(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Next ',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () => _saveForm(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    final isValid = _nameFormKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _nameFormKey.currentState.save();
  }

  void _saveName(String name) {
    final workoutProgramsProvider =
        Provider.of<WorkoutPrograms>(context, listen: false);
    workoutProgramsProvider.nameNewProgram(
      name: name,
      clientId: widget.clientId,
    );
    widget.nameWasGiven();
  }
}

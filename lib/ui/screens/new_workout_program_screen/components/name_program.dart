import 'package:flutter/material.dart';

import '../../../../services/validator.dart';

class NameProgram extends StatelessWidget {
  final String clientId;
  final Function nameProgram;
  final _nameFormKey = GlobalKey<FormState>();

  NameProgram(this.clientId, this.nameProgram);

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
                validator: Validator.validateForEmptyString,
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                onSaved: (value) => nameProgram(value),
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
                onPressed: _saveForm,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    final isValid = _nameFormKey.currentState.validate();

    if (isValid) {
      _nameFormKey.currentState.save();
    }
  }
}

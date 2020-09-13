import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

import '../models/client.dart';

class AddClientScreen extends StatefulWidget {
  static const routeName = '/add-client';

  @override
  _AddClientScreenState createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _lastNameFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _heightFocusNode = FocusNode();
  final _addClientForm = GlobalKey<FormState>();

  DateTime _birthDate;

  void _saveForm() {
    final isFormValid = _addClientForm.currentState.validate();
    if (!isFormValid) {
      return;
    }
  }

  String _validateForEmptyString(String value) {
    if (value.isEmpty) {
      return 'This field cannnot be empty.';
    }
    return null;
  }

  String _validateHeight(String value) {
    if (_validateForEmptyString(value) != null) {
      return "Please provide height.";
    }
    var height = int.parse(value);
    if (height < 100 || height > 250) {
      return "Please provide valid height in centimeters.";
    }
    return null;
  }

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime(1980),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _birthDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Client'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _addClientForm,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                textInputAction: TextInputAction.next,
                validator: (value) => _validateForEmptyString(value),
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_lastNameFocusNode),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) => _validateForEmptyString(value),
                textInputAction: TextInputAction.next,
                focusNode: _lastNameFocusNode,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_genderFocusNode),
              ),
              DropdownButtonFormField(
                focusNode: _genderFocusNode,
                value: 'Man',
                items: [
                  DropdownMenuItem(
                    value: 'Man',
                    child: Row(
                      children: [
                        Icon(MdiIcons.humanMale),
                        SizedBox(width: 10),
                        Text('Man'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Woman',
                    child: Row(
                      children: [
                        Icon(MdiIcons.humanFemale),
                        SizedBox(width: 10),
                        Text('Woman'),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) {
                  FocusScope.of(context).requestFocus(_heightFocusNode);
                },
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: _birthDate == null
                          ? Text('Choose Birth Date')
                          : Text(
                              'Birth Date: ${DateFormat.yMd().format(_birthDate)}'),
                    ),
                    RaisedButton(
                      child: Text('Choose Date'),
                      onPressed: _pickDate,
                    ),
                  ],
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Height'),
                validator: (value) => _validateHeight(value),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _heightFocusNode,
              ),
              SizedBox(height: 50),
              FlatButton(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Add',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  _saveForm();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

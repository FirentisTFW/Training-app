import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

import '../database/database_provider.dart';
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
  var _client = Client(
    id: DateTime.now().toString(),
    firstName: '',
    lastName: '',
    gender: '',
    height: 0,
    bodyweight: 0,
  );

  @override
  void dispose() {
    _lastNameFocusNode.dispose();
    _genderFocusNode.dispose();
    _heightFocusNode.dispose();
    super.dispose();
  }

  // TODO: improve this - move to client class
  void _updateClient(String field, String value) {
    _client = Client(
      id: _client.id,
      firstName: (field == 'firstName') ? value : _client.firstName,
      lastName: (field == 'lastName') ? value : _client.lastName,
      gender: (field == 'gender') ? value : _client.gender,
      height: (field == 'height') ? int.parse(value) : _client.height,
      bodyweight: _client.bodyweight,
    );
  }

  Future<void> _saveForm() async {
    final isFormValid = _addClientForm.currentState.validate();
    if (!isFormValid) {
      return;
    }
    _addClientForm.currentState.save();
    await DatabaseProvider.db.insertIntoDatabase(_client, 'clients');
    Navigator.of(context).pop();
  }

  // TODO: move validators to different class
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
                onSaved: (value) => _updateClient('firstName', value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) => _validateForEmptyString(value),
                textInputAction: TextInputAction.next,
                focusNode: _lastNameFocusNode,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_genderFocusNode),
                onSaved: (value) => _updateClient('lastName', value),
              ),
              DropdownButtonFormField(
                focusNode: _genderFocusNode,
                value: 'Man',
                items: [
                  // TODO: put these options in builder function
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
                onSaved: (value) => _updateClient('gender', value),
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
                onSaved: (value) => _updateClient('height', value.toString()),
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

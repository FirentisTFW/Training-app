import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/validator.dart';
import '../models/client.dart';
import '../providers/clients.dart';

class NewClientScreen extends StatefulWidget {
  static const routeName = '/add-client';

  @override
  _NewClientScreenState createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  final _addClientForm = GlobalKey<FormState>();
  final _lastNameFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _heightFocusNode = FocusNode();
  final _bodyweightFocusNode = FocusNode();
  DateTime _birthDate;
  var _client = Client(
    id: DateTime.now().toString(),
    firstName: '',
    lastName: '',
    gender: '',
    birthDate: null,
    height: 0,
    bodyweight: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Client')),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _addClientForm,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                validator: (value) => Validator.validateForEmptyString(value),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_lastNameFocusNode),
                onSaved: (value) => _updateClient('firstName', value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                keyboardType: TextInputType.name,
                validator: (value) => Validator.validateForEmptyString(value),
                textInputAction: TextInputAction.next,
                focusNode: _lastNameFocusNode,
                onFieldSubmitted: (_) =>
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
                validator: (value) => Validator.validateHeight(value),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _heightFocusNode,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_bodyweightFocusNode),
                onSaved: (value) => _updateClient('height', value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Bodyweight (optional)'),
                validator: (value) => Validator.validateBodyweight(value),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _bodyweightFocusNode,
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                onSaved: (value) => _updateClient('bodyweight', value),
              ),
              SizedBox(height: 50),
              FlatButton(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(10),
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

  @override
  void dispose() {
    _lastNameFocusNode.dispose();
    _genderFocusNode.dispose();
    _heightFocusNode.dispose();
    _bodyweightFocusNode.dispose();
    super.dispose();
  }

  // TODO: improve this - move to client class
  void _updateClient(String field, dynamic value) {
    _client = Client(
      id: _client.id,
      firstName: (field == 'firstName') ? value : _client.firstName,
      lastName: (field == 'lastName') ? value : _client.lastName,
      gender: (field == 'gender') ? value : _client.gender,
      birthDate: (field == 'birthDate') ? value : _client.birthDate,
      height: (field == 'height') ? int.parse(value) : _client.height,
      bodyweight:
          (field == 'bodyweight') ? int.parse(value) : _client.bodyweight,
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _saveForm() async {
    final isFormValid = _addClientForm.currentState.validate();
    if (!isFormValid) {
      return;
    }
    if (_birthDate == null) {
      _showErrorDialog("Please provide birth date.");
      return;
    }
    _addClientForm.currentState.save();
    final clientsProvider = Provider.of<Clients>(context, listen: false);
    clientsProvider.addNewClient(_client);
    await clientsProvider.writeToFile();
    Navigator.of(context).pop();
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
        _updateClient('birthDate', _birthDate);
      });
    });
  }
}
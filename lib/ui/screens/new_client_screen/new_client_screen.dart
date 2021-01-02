import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/ui/dialogs/information_dialog.dart';

import '../../../services/validator.dart';
import '../../../models/client.dart';
import '../../../providers/clients.dart';
import 'components/date_picker.dart';
import 'components/gender_selection.dart';

class NewClientScreen extends StatefulWidget {
  static const routeName = '/add-client';

  @override
  _NewClientScreenState createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  final _addClientForm = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();

  var _client = Client(
    id: DateTime.now().toString(),
    firstName: null,
    lastName: null,
    gender: null,
    birthDate: null,
    height: null,
  );

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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
                onFieldSubmitted: (_) => _focusNode.requestFocus(),
                onSaved: (value) => _updateClient('firstName', value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                validator: (value) => Validator.validateForEmptyString(value),
                onFieldSubmitted: (_) => _focusNode.requestFocus(),
                onSaved: (value) => _updateClient('lastName', value),
              ),
              GenderSelection(_updateClient),
              DatePicker(_updateClient),
              TextFormField(
                decoration: InputDecoration(labelText: 'Height'),
                validator: (value) => Validator.validateHeight(value),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) => _focusNode.requestFocus(),
                onSaved: (value) => _updateClient('height', int.parse(value)),
              ),
              SizedBox(height: 50),
              FlatButton(
                color: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                onPressed: _saveForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateClient(String field, dynamic value) {
    if (field == 'firstName')
      _client = _client.copyWith(firstName: value);
    else if (field == 'lastName')
      _client = _client.copyWith(lastName: value);
    else if (field == 'gender')
      _client = _client.copyWith(gender: value);
    else if (field == 'birthDate')
      _client = _client.copyWith(birthDate: value);
    else if (field == 'height') _client = _client.copyWith(height: value);
  }

  Future _saveForm() async {
    final isFormValid = _addClientForm.currentState.validate();
    if (!isFormValid) {
      return;
    }
    if (_client.birthDate == null) {
      await InformationDialogs.showInformationDialog(context,
          title: 'Form incomplete', message: 'Please provide birth date.');
      return;
    }
    _addClientForm.currentState.save();

    await _addClient();
  }

  Future _addClient() async {
    final clientsProvider = Provider.of<Clients>(context, listen: false);

    try {
      clientsProvider.addNewClient(_client);
      await clientsProvider.writeToFile();
      Navigator.of(context).pop();
    } catch (err) {
      // TODO: error handling
      print(err.toString());
    }
  }
}

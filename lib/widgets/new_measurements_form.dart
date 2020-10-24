import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/validator.dart';
import '../models/measurement_session.dart';
import '../models/measurement.dart';
import '../models/body_measurement.dart';
import '../providers/measurements.dart';

class NewMeasurementsForm extends StatefulWidget {
  final String clientId;

  NewMeasurementsForm(this.clientId);

  @override
  _NewMeasurementsFormState createState() => _NewMeasurementsFormState();
}

class _NewMeasurementsFormState extends State<NewMeasurementsForm> {
  final _newMeasurementsForm = GlobalKey<FormState>();
  final _focusNode = FocusScopeNode();
  MeasurementSession _measurementSession;
  List<dynamic> _measurements;

  @override
  void initState() {
    super.initState();
    _measurementSession = MeasurementSession(
      id: DateTime.now().toString(),
      clientId: widget.clientId,
      date: DateTime.now(),
      measurements: [],
    );
    _measurements = [];
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _newMeasurementsForm,
      child: FocusScope(
        node: _focusNode,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Fill in only fields which was measured',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            _buildTextFormField(
              labelText: 'Bodyweight',
              onSaved: null,
            ),
            _buildTextFormField(
              labelText: 'Bodyfat',
              onSaved: null,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Body Measurements:',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            _buildTextFormField(
              labelText: 'Arm',
              onSaved: null,
            ),
            _buildTextFormField(
              labelText: 'Calf',
              onSaved: null,
            ),
            _buildTextFormField(
              labelText: 'Chest',
              onSaved: null,
            ),
            _buildTextFormField(
              labelText: 'Forearm',
              onSaved: null,
            ),
            _buildTextFormField(
              labelText: 'Hips',
              onSaved: null,
            ),
            _buildTextFormField(
              labelText: 'Thigh',
              onSaved: null,
            ),
            _buildTextFormField(
              labelText: 'Waist',
              onSaved: null,
            ),
            Container(
              height: 50,
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Save',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  _saveForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _buildTextFormField({
    @required String labelText,
    @required Function onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) => Validator.validateForDoubleNumberOrEmpty(value),
      onEditingComplete: _focusNode.nextFocus,
      onSaved: (value) => _saveMeasurement(value, labelText),
    );
  }

  void _saveForm() {
    final isValid = _newMeasurementsForm.currentState.validate();
    if (!isValid) {
      return;
    }
    _newMeasurementsForm.currentState.save();
    _measurementSession =
        _measurementSession.copyWith(measurements: _measurements);
    print(_measurements);
    final measurementsProvider =
        Provider.of<Measurements>(context, listen: false);
    measurementsProvider.addMeasurementSession(_measurementSession);
    measurementsProvider.writeToFile();
    Navigator.of(context).pop();
  }

  void _saveMeasurement(String value, String type) {
    if (value.isEmpty) {
      return;
    }
    var measurementType = MeasurementType.BodyMeasurement;
    var bodypart;
    switch (type) {
      case 'Bodyweight':
        measurementType = MeasurementType.Bodyweight;
        break;
      case 'Bodyfat':
        measurementType = MeasurementType.Bodyfat;
        break;
      case 'Arm':
        bodypart = Bodypart.Arm;
        break;
      case 'Calf':
        bodypart = Bodypart.Calf;
        break;
      case 'Chest':
        bodypart = Bodypart.Chest;
        break;
      case 'Forearm':
        bodypart = Bodypart.Forearm;
        break;
      case 'Hips':
        bodypart = Bodypart.Hips;
        break;
      case 'Thigh':
        bodypart = Bodypart.Thigh;
        break;
      case 'Waist':
        bodypart = Bodypart.Waist;
        break;
    }
    if (measurementType != MeasurementType.BodyMeasurement) {
      setState(() {
        _measurements.add(Measurement(
          value: double.parse(value),
          type: measurementType,
        ));
      });
    } else {
      setState(() {
        _measurements.add(BodyMeasurement(
          bodypart: bodypart,
          value: double.parse(value),
          type: measurementType,
        ));
      });
    }
  }
}

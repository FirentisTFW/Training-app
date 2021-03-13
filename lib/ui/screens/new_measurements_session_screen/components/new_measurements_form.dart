import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/services/measurements_service.dart';
import 'package:training_app/ui/dialogs/information_dialog.dart';
import 'package:training_app/ui/screens/new_measurements_session_screen/components/single_measurement_input.dart';

import '../../../../models/measurement_session.dart';
import '../../../../models/measurement.dart';
import '../../../../models/body_measurement.dart';
import '../../../../providers/measurements.dart';

class NewMeasurementsForm extends StatefulWidget {
  final String clientId;

  NewMeasurementsForm(this.clientId);

  @override
  _NewMeasurementsFormState createState() => _NewMeasurementsFormState();
}

class _NewMeasurementsFormState extends State<NewMeasurementsForm> {
  final _newMeasurementsForm = GlobalKey<FormState>();
  final _focusNode = FocusScopeNode();

  List<Measurement> _measurements = [];
  List<BodyMeasurement> _bodyMeasurements = [];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _newMeasurementsForm,
      child: FocusScope(
        node: _focusNode,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Fill in only fields which were measured',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            SingleMeasurementInput(
              labelText: 'Bodyweight',
              suffix: 'kg',
              focusNode: _focusNode,
              onSaved: _saveMeasurement,
            ),
            SingleMeasurementInput(
              labelText: 'Bodyfat',
              suffix: '%',
              focusNode: _focusNode,
              onSaved: _saveMeasurement,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Body Measurements:',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            ..._buildBodyMeasurementsInputs(),
            Container(
              height: 50,
              child: FlatButton(
                onPressed: _addSessionOrShowErrorSnackbar,
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Save',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBodyMeasurementsInputs() {
    final bp = ['Arm', 'Calf', 'Chest', 'Forearm', 'Hips', 'Thigh', 'Waist'];
    List<Widget> measurementInputs = [];

    for (int i = 0; i < bp.length; i++) {
      measurementInputs.add(
        SingleMeasurementInput(
          labelText: bp[i],
          suffix: 'cm',
          focusNode: _focusNode,
          onSaved: _saveMeasurement,
        ),
      );
    }
    return measurementInputs;
  }

  void _addSessionOrShowErrorSnackbar() async {
    final isValid = _newMeasurementsForm.currentState.validate();

    if (isValid) {
      _newMeasurementsForm.currentState.save();
      final measurementSession = _createMeasurementSession();
      final measurementsProvider =
          Provider.of<Measurements>(context, listen: false);

      try {
        measurementsProvider.addMeasurementSession(measurementSession);
        await measurementsProvider.writeToFile();

        Navigator.of(context).pop();
      } catch (err) {
        measurementsProvider.deleteMeasurementSession(measurementSession.id);
        InformationDialogs.showSnackbar(
            'Couldn\'t add measurement session. Try again.', context);
      }
    }
  }

  MeasurementSession _createMeasurementSession() => MeasurementSession(
        id: DateTime.now().toString(),
        clientId: widget.clientId,
        date: DateTime.now(),
        measurements: _measurements,
        bodyMeasurements: _bodyMeasurements,
      );

  void _saveMeasurement(String value, String type) {
    if (value.isEmpty) {
      return;
    }
    var measurementType = MeasurementsService.getMeasurementType(type);

    if (measurementType == MeasurementType.BodyMeasurement) {
      var bodypart = MeasurementsService.getBodypart(type);

      _bodyMeasurements.add(BodyMeasurement(
        bodypart: bodypart,
        value: double.parse(value),
        type: measurementType,
      ));
    } else {
      _measurements.add(Measurement(
        value: double.parse(value),
        type: measurementType,
      ));
    }
  }
}

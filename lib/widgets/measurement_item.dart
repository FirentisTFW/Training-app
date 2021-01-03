import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/ui/dialogs/confirmation.dart';
import 'package:training_app/providers/measurements.dart';
import 'package:training_app/ui/universal_components/pop_up_menu.dart';

import '../models/measurement_session.dart';
import '../models/body_measurement.dart';

class MeasurementItem extends StatefulWidget {
  final MeasurementSession measurementSession;

  MeasurementItem(this.measurementSession);

  @override
  _MeasurementItemState createState() => _MeasurementItemState();
}

class _MeasurementItemState extends State<MeasurementItem> {
  var _isExpanded = false;
  Offset _tapPosition;

  @override
  Widget build(BuildContext context) {
    final bodyweight = widget.measurementSession.getBodyweight();
    final bodyfat = widget.measurementSession.getBodyfat();
    final bodyMeasurements = widget.measurementSession.getBodyMeasurements();
    return InkWell(
      onTapDown: _storePosition,
      onLongPress: _showPopUpMenuAndChooseOption,
      child: Container(
        height: getFinalHeight(
            bodyMeasurements != null ? bodyMeasurements.length : null),
        child: Card(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    DateFormat.yMd().format(widget.measurementSession.date),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                if (bodyweight != null) showAttribute('Bodyweight', bodyweight),
                if (bodyfat != null) showAttribute('Bodyfat', bodyfat),
                if (bodyMeasurements != null)
                  showMeasurementsList(bodyMeasurements),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _showPopUpMenuAndChooseOption() async {
    final chosenOption = await PopUpMenu.createPopUpMenuAndChooseOption(
      context,
      _tapPosition,
    );
    if (chosenOption == 'delete') {
      await _deleteMeasurementSession();
    }
  }

  Future<void> _deleteMeasurementSession() async {
    if (!await _confirmDeletion()) {
      return;
    }

    final measurementsProvider =
        Provider.of<Measurements>(context, listen: false);
    measurementsProvider.deleteMeasurementSession(widget.measurementSession.id);
    await measurementsProvider.writeToFile();
    Confirmation.displayMessage('Measurements session deleted.', context);
  }

  Future<bool> _confirmDeletion() async {
    return await Confirmation.confirmationDialog(context);
  }

  double getFinalHeight(bodyMeasurementsLength) {
    if (bodyMeasurementsLength == null) {
      return 120.0;
    }
    if (_isExpanded) {
      return 190.0 + bodyMeasurementsLength * 30.0;
    }
    return 190.0;
  }

  Widget showAttribute(String attributeName, double value) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        attributeName +
            ':  ' +
            value.toString() +
            getTrailForAttribute(attributeName),
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  String getTrailForAttribute(String attributeName) {
    if (attributeName == 'Bodyweight') {
      return ' kg';
    }
    if (attributeName == 'Bodyfat') {
      return '%';
    }
    return ' cm';
  }

  Widget showMeasurementsList(List<BodyMeasurement> measurements) {
    return Column(
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 20),
            const Text(
              'Body Measurements',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            IconButton(
              icon: _isExpanded
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            )
          ],
        ),
        if (_isExpanded)
          ...measurements.map(
            (measurement) => Container(
              child: showAttribute(
                measurement.bodypart.toString().substring(9),
                measurement.value,
              ),
            ),
          ),
      ],
    );
  }
}

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/ui/dialogs/confirmation.dart';
import 'package:training_app/providers/measurements.dart';
import 'package:training_app/ui/dialogs/information_dialog.dart';
import 'package:training_app/ui/screens/measurements_screen/components/single_measurement_attribute.dart';
import 'package:training_app/ui/universal_components/pop_up_menu.dart';

import '../../../../models/measurement_session.dart';
import 'body_measurements_widgets.dart';

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
        height: getHeight(bodyMeasurements?.length ?? null),
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
                if (bodyweight != null)
                  SingleMeasurementAttribute(
                      name: 'Bodyweight', value: bodyweight),
                if (bodyfat != null)
                  SingleMeasurementAttribute(name: 'Bodyfat', value: bodyfat),
                if (bodyMeasurements.isNotEmpty)
                  BodyMeasurementsButton(_isExpanded, _expand),
                if (_isExpanded && bodyMeasurements.isNotEmpty)
                  BodyMeasurementsList(bodyMeasurements),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _expand() => setState(() => _isExpanded = !_isExpanded);

  void _storePosition(TapDownDetails details) =>
      _tapPosition = details.globalPosition;

  void _showPopUpMenuAndChooseOption() async {
    final chosenOption = await PopUpMenu.createPopUpMenuAndChooseOption(
      context,
      _tapPosition,
    );

    if (chosenOption == 'delete') {
      await _deleteMeasurementSessionAndShowSnackbar();
    }
  }

  Future _deleteMeasurementSessionAndShowSnackbar() async {
    if (await _confirmDeletion()) {
      final measurementsProvider =
          Provider.of<Measurements>(context, listen: false);

      try {
        measurementsProvider
            .deleteMeasurementSession(widget.measurementSession.id);
        await measurementsProvider.writeToFile();
        InformationDialogs.showSnackbar(
            'Measurements session deleted.', context);
      } catch (err) {
        InformationDialogs.showSnackbar(
            'Couldn\'t delete measurements session.', context);
      }
    }
  }

  Future<bool> _confirmDeletion() async =>
      await Confirmation.confirmationDialog(context);

  double getHeight(bodyMeasurementsLength) {
    if (bodyMeasurementsLength == null) {
      return 120.0;
    }
    if (_isExpanded) {
      return 190.0 + bodyMeasurementsLength * 30.0;
    }
    return 190.0;
  }
}

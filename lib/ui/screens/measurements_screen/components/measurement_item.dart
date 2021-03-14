import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/body_measurement.dart';
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
  _MeasurementItemState createState() => _MeasurementItemState(
        bodyweight: measurementSession.getBodyweight(),
        bodyfat: measurementSession.getBodyfat(),
        bodyMeasurements: measurementSession.bodyMeasurements,
        date: measurementSession.date,
      );
}

class _MeasurementItemState extends State<MeasurementItem> {
  final double bodyweight;
  final double bodyfat;
  final List<BodyMeasurement> bodyMeasurements;
  final DateTime date;

  var _isExpanded = false;
  var _animationFinished = false;
  Offset _tapPosition;

  _MeasurementItemState({
    @required this.bodyweight,
    @required this.bodyfat,
    @required this.bodyMeasurements,
    @required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: _storePosition,
      onLongPress: _showPopUpMenuAndChooseOption,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: getHeight(bodyMeasurements?.length ?? null),
        onEnd: () => setState(() => _animationFinished = true),
        child: Card(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    DateFormat.yMd().format(date),
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
                if (_isExpanded &&
                    bodyMeasurements.isNotEmpty &&
                    _animationFinished)
                  Flexible(child: BodyMeasurementsList(bodyMeasurements)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _expand() => setState(() {
        _animationFinished = false;
        _isExpanded = !_isExpanded;
      });

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
    final dateHeight = 70;
    final bodyweightHeight = bodyweight != null ? 30.0 : 0;
    final bodyfatHeight = bodyfat != null ? 30.0 : 0;
    final measurementsBasicHeight = bodyMeasurementsLength != 0 ? 60.0 : 0;

    if (_isExpanded) {
      return dateHeight +
          bodyweightHeight +
          bodyfatHeight +
          measurementsBasicHeight +
          bodyMeasurementsLength * 30.0;
    }
    return dateHeight +
        bodyweightHeight +
        bodyfatHeight +
        measurementsBasicHeight;
  }
}

import 'package:flutter/material.dart';
import 'package:training_app/models/body_measurement.dart';
import 'package:training_app/ui/screens/measurements_screen/components/single_measurement_attribute.dart';

class BodyMeasurementsButton extends StatelessWidget {
  final bool _isExpanded;
  final Function _expand;

  const BodyMeasurementsButton(this._isExpanded, this._expand);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            const Text(
              'Body Measurements',
              style: const TextStyle(fontSize: 20),
            ),
            IconButton(
              icon: _isExpanded
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
              onPressed: _expand,
            )
          ],
        ),
      ],
    );
  }
}

class BodyMeasurementsList extends StatelessWidget {
  final List<BodyMeasurement> measurements;

  const BodyMeasurementsList(this.measurements);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...measurements.map(
          (measurement) => Container(
            child: SingleMeasurementAttribute(
              name: measurement.bodypart.toString().substring(9),
              value: measurement.value,
            ),
          ),
        ),
      ],
    );
  }
}

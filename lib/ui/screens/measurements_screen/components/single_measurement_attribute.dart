import 'package:flutter/material.dart';

class SingleMeasurementAttribute extends StatelessWidget {
  final String name;
  final double value;

  const SingleMeasurementAttribute({Key key, this.name, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        name + ':  ' + value.toString() + getTrailForAttribute(name),
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  String getTrailForAttribute(String name) {
    switch (name) {
      case 'Bodyweight':
        return ' kg';
      case 'Bodyfat':
        return ' %';
      default:
        return ' cm';
    }
  }
}

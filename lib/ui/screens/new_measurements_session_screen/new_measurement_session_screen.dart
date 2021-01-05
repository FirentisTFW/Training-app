import 'package:flutter/material.dart';

import 'components/new_measurements_form.dart';

class NewMeasurementSessionScreen extends StatelessWidget {
  static const routeName = '/new-measurement';

  @override
  Widget build(BuildContext context) {
    final clientId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: NewMeasurementsForm(clientId),
      ),
    );
  }
}

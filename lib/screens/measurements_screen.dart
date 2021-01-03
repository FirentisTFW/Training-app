import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/screens/new_measurement_screen.dart';
import 'package:training_app/widgets/measurement_item.dart';
import 'package:training_app/ui/universal_components/no_items_added_yet_informator.dart';

import '../providers/measurements.dart';

class MeasurementsScreen extends StatefulWidget {
  static const routeName = '/measurements';

  @override
  _MeasurementsScreenState createState() => _MeasurementsScreenState();
}

class _MeasurementsScreenState extends State<MeasurementsScreen> {
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      Provider.of<Measurements>(context).fetchMeasurements().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientId = ModalRoute.of(context).settings.arguments;
    final measurementsProvider = Provider.of<Measurements>(context);
    final measurements = measurementsProvider.findByClientId(clientId);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).pushNamed(
                NewMeasurementScreen.routeName,
                arguments: clientId,
              );
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            )
          : measurements.length == 0
              ? NoItemsAddedYetInformator('No measurements taken yet.')
              : ListView.builder(
                  itemCount: measurements.length,
                  itemBuilder: (ctx, index) {
                    return MeasurementItem(measurements[index]);
                  },
                ),
    );
  }
}

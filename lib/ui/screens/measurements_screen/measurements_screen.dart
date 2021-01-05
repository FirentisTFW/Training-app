import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/screens/new_measurement_screen.dart';
import 'package:training_app/ui/screens/measurements_screen/components/measurement_item.dart';
import 'package:training_app/ui/universal_components/loading_spinner.dart';
import 'package:training_app/ui/universal_components/no_items_added_yet_informator.dart';

import '../../../providers/measurements.dart';

class MeasurementsScreen extends StatefulWidget {
  static const routeName = '/measurements';

  @override
  _MeasurementsScreenState createState() => _MeasurementsScreenState();
}

class _MeasurementsScreenState extends State<MeasurementsScreen> {
  var _isLoading = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isLoading) {
      await Provider.of<Measurements>(context).fetchMeasurements();

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientId = ModalRoute.of(context).settings.arguments;
    final measurementsProvider = Provider.of<Measurements>(context);
    final measurements =
        _isLoading ? null : measurementsProvider.findByClientId(clientId);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30,
            onPressed: () => goToNewMeasurementScreen(clientId),
          )
        ],
      ),
      body: _isLoading
          ? LoadingSpinner()
          : measurements.length == 0
              ? NoItemsAddedYetInformator('No measurements taken yet.')
              : ListView.builder(
                  itemCount: measurements.length,
                  itemBuilder: (ctx, index) =>
                      MeasurementItem(measurements[index]),
                ),
    );
  }

  Future goToNewMeasurementScreen(String clientId) =>
      Navigator.of(context).pushNamed(
        NewMeasurementScreen.routeName,
        arguments: clientId,
      );
}

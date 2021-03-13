import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/ui/universal_components/loading_spinner.dart';

import '../../../providers/workouts.dart';
import 'components/workout_item.dart';
import '../../universal_components/no_items_added_yet_informator.dart';

class CompletedWorkoutScreen extends StatefulWidget {
  static const routeName = '/done-workouts';

  @override
  _CompletedWorkoutScreenState createState() => _CompletedWorkoutScreenState();
}

class _CompletedWorkoutScreenState extends State<CompletedWorkoutScreen> {
  var _isLoading = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isLoading) {
      await Provider.of<Workouts>(context).fetchWorkouts();

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientId = ModalRoute.of(context).settings.arguments;
    final workoutsData = Provider.of<Workouts>(context);
    final workouts = workoutsData.findByClientId(clientId).reversed.toList();

    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? LoadingSpinner()
          : workouts.length == 0
              ? NoItemsAddedYetInformator('No workouts completed yet.')
              : ListView.builder(
                  itemCount: workouts.length,
                  itemBuilder: (ctx, index) {
                    return WorkoutItem(workouts[index]);
                  },
                ),
    );
  }
}

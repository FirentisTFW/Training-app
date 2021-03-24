import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/workouts.dart';
import 'components/workout_item.dart';
import '../../universal_components/no_items_added_yet_informator.dart';

class CompletedWorkoutScreen extends StatelessWidget {
  static const routeName = '/done-workouts';

  @override
  Widget build(BuildContext context) {
    final clientId = ModalRoute.of(context).settings.arguments;
    final workoutsData = Provider.of<Workouts>(context);
    final workouts = workoutsData.findByClientId(clientId).reversed.toList();

    return Scaffold(
      appBar: AppBar(),
      body: workouts.length == 0
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

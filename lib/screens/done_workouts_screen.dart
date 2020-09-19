import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workouts.dart';
import '../widgets/workout_item.dart';

class DoneWorkoutScreen extends StatelessWidget {
  static const routeName = '/done-workouts';

  @override
  Widget build(BuildContext context) {
    final workoutsData = Provider.of<Workouts>(context);
    final workouts = workoutsData.findByClientId('0');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (ctx, index) {
          return WorkoutItem(
            workouts[index],
          );
        },
      ),
    );
  }
}

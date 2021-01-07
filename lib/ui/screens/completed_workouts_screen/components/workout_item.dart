import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:training_app/screens/edit_workout_screen.dart';
import 'package:training_app/ui/screens/workout_details_screen/workout_details_screen.dart';
import 'package:training_app/ui/dialogs/information_dialog.dart';
import 'package:training_app/ui/universal_components/pop_up_menu.dart';

import '../../../dialogs/confirmation.dart';
import '../../../../models/workout.dart';
import '../../../../providers/workouts.dart';

// ignore: must_be_immutable
class WorkoutItem extends StatelessWidget {
  final Workout workout;
  Offset _tapPosition;

  WorkoutItem(this.workout);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToWorkoutDetailsScreen(context),
      onTapDown: _storePosition,
      onLongPress: () => _showPopUpMenuAndChooseOption(context),
      child: Container(
        height: 100,
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat.yMd().format(workout.date),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  workout.programName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future goToWorkoutDetailsScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(
        WorkoutDetailsScreen.routeName,
        arguments: workout,
      );

  Future goToEditWorkoutScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(
        EditWorkoutScreen.routeName,
        arguments: workout,
      );

  void _storePosition(TapDownDetails details) =>
      _tapPosition = details.globalPosition;

  void _showPopUpMenuAndChooseOption(BuildContext context) async {
    final chosenOption =
        await PopUpMenu.createPopUpMenuAndChooseOption(context, _tapPosition);

    if (chosenOption == 'delete') {
      await deleteWorkout(context);
    } else if (chosenOption == 'edit') {
      goToEditWorkoutScreen(context);
    }
  }

  Future deleteWorkout(BuildContext context) async {
    if (await confirmDeletion(context)) {
      final workoutsProvider = Provider.of<Workouts>(context, listen: false);

      try {
        workoutsProvider.deleteWorkout(workout.id);
        await workoutsProvider.writeToFile();
        InformationDialogs.showSnackbar('Workout deleted.', context);
      } catch (err) {
        InformationDialogs.showSnackbar('Couldn\'t delete workout.', context);
      }
    }
  }

  Future<bool> confirmDeletion(BuildContext context) async =>
      await Confirmation.confirmationDialog(context);
}
